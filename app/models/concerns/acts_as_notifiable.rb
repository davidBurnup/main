module ActsAsNotifiable

  extend ActiveSupport::Concern

  included do

    has_many :notifications, dependent: :destroy, as: :notifiable

    after_save :create_notifications


    def create_notifications
      notifiable_users.each do |user|
        Notification.create({
          notified: user,
          notifier: notifing_user,
          notifiable: self
        })
      end
    end

    # This method returns notifiable users for the current notifiable instance
    def notifiable_users
      raise "You need to implement 'notifiable_users' method into your notifiable model #{self.class.name}"
    end

    # This method returns notifying user for the current notifiable instance
    def notifing_user
      raise "You need to implement 'notifing_user' method into your notifiable model #{self.class.name}"
    end

    def notifiable_content
      nil
    end

  end
end
