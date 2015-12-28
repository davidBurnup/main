class Notification < ActiveRecord::Base

  belongs_to :notifiable, polymorphic: true
  belongs_to :notifier, class_name: "User"
  belongs_to :notified, class_name: "User"


  scope :unseen, -> {
    where('notifications.is_seen = false OR notifications.is_seen IS NULL')
  }

end
