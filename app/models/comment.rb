class Comment < ApplicationRecord

  include ActsAsNotifiable
  include ActsAsCommentable::Comment
  
  acts_as_likeable

  stampable

  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }

  notifiable({
    content: :comment,
    trigger: :after_save,
    notifier: :creator,
    notifieds: lambda{|c|
      c.notifiable_users
    },
    icon: 'comment-o'
  })

  auto_html_for :comment do
    html_escape
    image
    youtube(:width => 300, :height => 200, :autoplay => false)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end


  def notifiable_users(only_self: false, origin_notifiable_resolver: nil)

    n_users_ids = []

    n_users_ids << self.creator.id if self.creator

    if !only_self and commentable
      n_users_ids += commentable.notifiable_users(origin_notifiable_resolver: self)
    end

    User.where("users.id IN (?)", n_users_ids)
  end

  def liked_notifiable_users

  end

  def notifing_user
    creator
  end

  def notifiable_content
    comment
  end

  def notifiable_through
    r_commentable = commentable
    if commentable_type.underscore == "public_activity/orm/active_record/activity"
      r_commentable = commentable.trackable
    end
    r_commentable
  end

  def root_activity
    commentable.root_activity
  end

end
