class Notification < ActiveRecord::Base

  belongs_to :notifiable, polymorphic: true
  belongs_to :notifier, class_name: "User"
  belongs_to :notified, class_name: "User"
  acts_as_paranoid

  after_create :notify!

  scope :unseen, -> {
    where('notifications.is_seen = false OR notifications.is_seen IS NULL')
  }

  def notify_through_ac
    notification_json = ApplicationController.new.view_context.render(
      partial: 'api/notifications/notification',
      locals: { self.class.model_name.to_s.underscore.to_sym => self, current_user: User.current },
      formats: [:json],
      handlers: [:jbuilder]
    )
    ActionCable.server.broadcast "notifications-for-user-#{self.notified_id}", notification_json
  end

  def set_as_seen!
    self.update(is_seen: true)
  end

  def notify!
    notify_through_ac
    # NotificationMailer.notify(self).deliver_now
  end


end
