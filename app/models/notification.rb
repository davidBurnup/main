class Notification < ActiveRecord::Base

  belongs_to :notifiable, polymorphic: true
  belongs_to :notifier, class_name: "User"
  belongs_to :notified, class_name: "User"

  after_create :send_push_notification

  scope :unseen, -> {
    where('notifications.is_seen = false OR notifications.is_seen IS NULL')
  }

  def send_push_notification
    ActionCable.server.broadcast "notifications-for-user-#{self.notified_id}", {
      id: self.id
    }
  end

end
