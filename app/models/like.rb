class Like < Socialization::ActiveRecordStores::Like

  include ActsAsNotifiable

  notifiable({
    content: lambda{|l|
      c = ""

      # Alias to #notifiable_content
      if l.likeable and l.likeable.respond_to? :notifiable_content
        c = l.likeable.notifiable_content
      end

      c
    },
    trigger: :after_save,
    notifier: :liker,
    notifieds: lambda{|l|
      n_users_ids = []

      if l.likeable and l.likeable.notifiable_users.present?
        n_users_ids = l.likeable.notifiable_users.collect(&:id)
      end

      User.where("users.id IN (?)", n_users_ids)
    },
    icon: 'heart-o'
  })

  before_save :fix_public_activity_path

  def like!(liker, likeable)
    unless likes?(liker, likeable)
      self.create! do |like|
        like.liker = liker
        like.likeable_type = likeable.class.table_name.classify
        like.likeable_id = likeable.id
      end
      call_after_create_hooks(liker, likeable)
      true
    else
      false
    end
  end

  def likeable_notification_content

  end

  def root_activity
    likeable.root_activity
  end

  def fix_public_activity_path
    if likeable_type and likeable_type == "Activity"
      self.likeable_type = "PublicActivity::Activity"
    end
  end

end
