class Post < ActiveRecord::Base
  include ActsAsFeedable
  include ActsAsNotifiable
  belongs_to :user
  belongs_to :song
  has_many :music_medias
  # has_many :medias

  accepts_nested_attributes_for :music_medias#, allow_destroy: true

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

      if p.creator
        title = "#{p.creator.short_name} a publié "
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
    }
  })

  # => only_self : gets notifiable users only for the current object
  def notifiable_users(only_self: false, origin_notifiable_resolver: nil)
    n_users_ids = []

    # Owner of the post
    if self.user
      n_users_ids << self.user.id

      # all users from the same church
      # if post was just created
      if self.id_changed? and self.user.church and only_self
        n_users_ids += self.user.church.users.collect(&:id)
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
