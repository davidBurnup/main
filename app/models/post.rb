class Post < ActiveRecord::Base

  belongs_to :user

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }, only: :create
  acts_as_commentable

  auto_html_for :content do
    html_escape
    image
    youtube(:width => 550, :height => 350, :autoplay => false)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  def latest_activity
    self.activities.order(:created_at => :desc).first
  end

end
