class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment
  include ActsAsNotifiable

  acts_as_likeable

  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }


  auto_html_for :comment do
    html_escape
    image
    youtube(:width => 300, :height => 200, :autoplay => false)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user

  def notifiable_users
    if commentable and commentable.respond_to? :notifiable_users
      commentable.notifiable_users
    end
  end

  def notifing_user
    user
  end

  def notifiable_content
    comment
  end

  def notification_commentable
    r_commentable = commentable
    if commentable_type.underscore == "public_activity/orm/active_record/activity"
      r_commentable = commentable.trackable
    end
    r_commentable
  end

end
