class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :song
  has_many :music_medias
  # has_many :medias

  accepts_nested_attributes_for :music_medias#, allow_destroy: true

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }, only: :create
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

end
