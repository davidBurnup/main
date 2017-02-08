class Meeting < ActiveRecord::Base
  include ActsAsFeedable
  include ActsAsNotifiable
  has_many :meeting_users
  has_one :practice
  has_many :meeting_songs

  accepts_nested_attributes_for :meeting_users, :practice, :meeting_songs, reject_if: :all_blank, allow_destroy: true

  validates :start_at, :presence => true
  validates :label, :presence => true

  after_save :format_label, :plan_practice_notifications

  acts_as_commentable

  notifiable({
    content: :label,
    trigger: :after_save,
    notifier: :creator,
    notifieds: lambda{|m|
      m.notifiable_users
    },
    icon: 'calendar-check-o'
  })

  feedable({
    title: lambda{|m|
      title = ""

      if m.creator
        title = "#{m.creator.full_name} a publié "
      end

      title
    },
    image: lambda{|m|
      m.creator ? m.creator.avatar.url(:tiny) : "/images/user.svg"
    }
  })

  def end_at
    Time.at(start_at.to_i + duration) if start_at and start_at.to_i > 0
  end

  def duration_in_hours
  	duration / 3600
  end

  # Notify meeting users (include leader) of the coming prcatice
  def notify_practice
    meeting_users.each do |meeting_user|
      if meeting_user.user and meeting_user.user.email and !meeting_user.was_notified?
        MeetingMailer.notify_practice(meeting_user).deliver
      end
    end
  end

  # => only_self : gets notifiable users only for the current object
  def notifiable_users(only_self: false, origin_notifiable_resolver: nil)
    n_users_ids = []

    # Owner of the meeting
    if self.creator
      n_users_ids << self.creator.id

      # all users from the same church
      # if post was just created
      if self.id_changed? and self.creator.church
        n_users_ids += self.creator.church.users.collect(&:id)
      end
    end

    # Invited users
    if self.meeting_users.present?
      n_users_ids += self.meeting_users.collect(&:id)
    end

    if a = self.activity
      unless only_self
        # And user who commented the post
        if comments = a.comments and comments.count > 0
          comments_notifiable_users_ids = comments.map do |c|
            if c != origin_notifiable_resolver
              c.notifiable_users(only_self: true, origin_notifiable_resolver: self).collect(&:user_id)
            else
              nil
            end
          end
          n_users_ids << comments_notifiable_users_ids.flatten.compact.uniq
        end
      end
    end

    User.where('users.id IN (?)', n_users_ids.flatten.compact.uniq)
  end

  def format_label
    if self.label.present?
      self.label = self.label.capitalize
    end
  end

  def leader
    if meeting_users and lds = meeting_users.leaders
      lds = lds.first
    end
    lds
  end

  def plan_practice_notifications
    if practice
      if practice.reminder > 0
        time_to_send = practice.start_at.to_i - practice.reminder
        diff_in_seconds = time_to_send - Time.now.to_i
        MeetingsWorker.perform_in(diff_in_seconds.seconds,self.id)
      else
        MeetingsWorker.perform_async(self.id)
      end
    end
  end

  def notifiable_content
    self.content.truncate(30)
  end

  def notification_editor
    creator
  end

  def root_activity
    activity
  end

end
