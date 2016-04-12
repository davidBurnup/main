class Post < ActiveRecord::Base
  include ActsAsFeedable
  belongs_to :user
  belongs_to :song
  has_many :music_medias
  # has_many :medias

  accepts_nested_attributes_for :music_medias#, allow_destroy: true

  stampable

  # include PublicActivity::Model
  # tracked owner: Proc.new{ |controller, model| controller.current_user }, only: :create
  acts_as_commentable

  auto_html_for :content do
    html_escape
    image
    soundcloud
    youtube(:width => 550, :height => 350, :autoplay => false)
    link :target => "_blank", :rel => "nofollow"
    simple_format
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

  def notifiable_users
    [user]
  end

  def notification_editor
    activity ? activity.owner : nil
  end

  def notifiable_content
    self.content.truncate(30)
  end

end
