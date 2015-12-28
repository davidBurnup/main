#encoding: utf-8
module ActivityExtension
  extend ActiveSupport::Concern

  included do
    def notifiable_users
      if owner and owner_type == "User"
        [owner]
      end
    end

    def notifiable_content
      if trackable and trackable.respond_to? :notifiable_content
        trackable.notifiable_content
      end
    end
  end
end
