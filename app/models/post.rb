class Post < ApplicationRecord
  include ActsAsFeedable
  include ActsAsNotifiable
  belongs_to :user
  belongs_to :song
  has_many :medias

  accepts_nested_attributes_for :medias#, allow_destroy: true

  stampable

  validates :user, presence: true
  # include PublicActivity::Model
  # tracked owner: Proc.new{ |controller, model| controller.current_user }, only: :create

  auto_html_for :content do
    html_escape
    image
    soundcloud
    youtube(:width => 550, :height => 350, :autoplay => false)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end


  notifiable({
    content: :content,
    trigger: :after_save,
    notifier: :user,
    notifieds: lambda{|p|
      p.notifiable_users
    },
    icon: 'newspaper-o'
  })

  feedable({
    title: lambda{|p|
      title = ""

      if p.creator and activity = p.activity
        title = "#{p.creator.short_name}"

        if activity.owner and activity.owner.respond_to? :feed_owner_option
          title = activity.owner.feed_owner_option(:title)
        end

        title += " a publié "
        if p.song and p.song.title.present?
          title += "à propos du chant #{p.song.title}"
        end
      end

      title
    },
    content: lambda{|p|
      p.content_html
    },
    image: lambda{|p|
      p.creator ? p.creator.avatar.url(:tiny) : "/images/user.svg"
    },
    image_link: lambda{|p|
      if p.song
        Rails.application.routes.url_helpers.song_path(p.song)
      end
    },
    recipient: lambda{|p|
      p.creator
    },
    is_draft: :is_draft,
    owner: lambda {|p, new_activity|
      o = p.creator
      if o and r = new_activity.recipient and r.is_a? Page and r.is_admin?(o)
        o = r
      end
      o
    }
  })



  # => only_self : gets notifiable users only for the current object
  def notifiable_users(only_self: false, origin_notifiable_resolver: nil)
    n_users_ids = []

    # Owner of the post
    if self.user
      n_users_ids << self.user.id

      # all users from the same page
      # if post was just created
      if self.id_changed? and self.user.page and only_self
        n_users_ids += self.user.page.users.collect(&:id)
      end
    end

    if a = self.activity
      unless only_self
        # And user who commented the post
        if comments = a.comments and comments.count > 0
          comments_notifiable_users_ids = comments.map do |c|
            if c != origin_notifiable_resolver
              c.notifiable_users(only_self: true, origin_notifiable_resolver: self).collect(&:id)
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

  def latest_activity
    self.activities.order(:created_at => :desc).first
  end

  def remove_blank_music_medias
    new_music_medias = []

    self.music_medias.each do |indeterminate_music_media|
      if indeterminate_music_media.attachment.present?
        new_music_medias << indeterminate_music_media
      end
    end

    self.music_medias = new_music_medias
  end

  def notification_editor
    activity ? activity.owner : nil
  end

  def notifiable_content
    self.content.truncate(30)
  end

  def root_activity
    activity
  end

end
