#encoding: utf-8
module ActivityExtension
  extend ActiveSupport::Concern

  included do

    acts_as_likeable
    acts_as_commentable

    scope :on, ->(recipient){
      where(recipient_type: recipient.class.to_s, recipient_id: recipient.id).published
    }

    scope :published, -> {
      where('activities.is_draft IS NOT true')
    }

    after_save :set_activity_visibility

    has_many :activities_visibilities, class_name: "::ActivityVisibility"
    # alias visibilities activity_visibilities

    def notifiable_users(only_self: false, origin_notifiable_resolver: nil)
      n_users_ids = []

      # Owner of the activity
      if owner and owner_type == "User"
        n_users_ids << owner.id
      end

      # Trackable notifiable users
      if trackable and trackable.respond_to? :notifiable_users and trackable.notifiable_users.present?
        n_users_ids = trackable.notifiable_users.collect(&:id)
      end

      User.where("users.id IN (?)", n_users_ids)
    end

    def notifiable_content
      if trackable and trackable.respond_to? :notifiable_content
        trackable.notifiable_content
      end
    end

    def root_activity
      self
    end

    def set_activity_visibility
      unless activities_visibilities.present?
        ActivityVisibility.create({
          activity: self
          })
      end
    end

    # def visibility
    #   activity_visibilities.collect(&:visibility)
    # end
  end
end
