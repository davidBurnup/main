class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }

  acts_as_likeable

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
end
