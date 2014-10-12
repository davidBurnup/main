class Meeting < ActiveRecord::Base

  has_many :meeting_users
  has_many :practices

  serialize :songs, Array

  accepts_nested_attributes_for :meeting_users, :practices, allow_destroy: true

  validates :start_at, :presence => true
  validates :label, :presence => true

  after_save :format_label, :plan_practice_notifications

  def end_at
    Time.at(start_at.to_i + duration) if start_at and start_at.to_i > 0
  end

  def duration_in_hours
  	duration / 3600
  end

  # Notify meeting users (include leader) of the coming prcatice
  def notify_practice
    meeting_users.each do |meeting_user|
      MeetingMailer.notify_practice(meeting_user).deliver if meeting_user.user and meeting_user.user.email
    end
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

  def practice
    practices.first if practices
  end

  def plan_practice_notifications
    if practice
      diff_in_seconds = practice.start_at.to_i - Time.now.to_i
      MeetingsWorker.perform_in(diff_in_seconds.seconds,self.id)
    end
  end

end
