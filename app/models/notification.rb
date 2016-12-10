class Notification < ActiveRecord::Base

  belongs_to :notifiable, polymorphic: true
  belongs_to :notifier, class_name: "User"
  belongs_to :notified, class_name: "User"

  after_create :send_push_notification

  scope :unseen, -> {
    where('notifications.is_seen = false OR notifications.is_seen IS NULL')
  }

  def send_push_notification
    notification_json = ApplicationController.new.view_context.render(
      partial: 'api/notifications/notification',
      locals: { self.class.model_name.to_s.underscore.to_sym => self },
      formats: [:json],
      handlers: [:jbuilder]
    )
    ActionCable.server.broadcast "notifications-for-user-#{self.notified_id}", notification_json
  end

end
