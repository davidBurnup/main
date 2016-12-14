class Comment < ActiveRecord::Base

  include ActsAsNotifiable
  include ActsAsCommentable::Comment

  acts_as_likeable

  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }

  notifiable({
    content: :comment,
    trigger: :after_save,
    notifier: :user,
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


  belongs_to :user

  def notifiable_users(only_self: false, origin_notifiable_resolver: nil)

    n_users_ids = []

    n_users_ids << self.user.id

    # Likers of the comment
    n_users_ids += likers(User).collect(&:id)

    if !only_self and commentable
      n_users_ids += commentable.notifiable_users(origin_notifiable_resolver: self)
    end

    User.where("users.id IN (?)", n_users_ids)
  end

  def liked_notifiable_users

  end

  def notifing_user
    user
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

end
