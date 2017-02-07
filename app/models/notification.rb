class Notification < ActiveRecord::Base

  belongs_to :notifiable, polymorphic: true
  belongs_to :notifier, class_name: "User"
  belongs_to :notified, class_name: "User"
  acts_as_paranoid

  after_create :notify!, :webpush

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
    NotificationMailer.notify(self).deliver_now# if Rails.env.development?
  end

  def webpush
    w = []
    if notified and notified.user_devices.present?
      notified.user_devices.each do |user_device|
        notification_data = {
          title: self.notifier.full_name,
          body: ApplicationController.helpers.build_notification_full_content(self),
          icon: "https://burnup.fr#{self.notifier.avatar.present? ? self.notifier.avatar.url(:cropped) : "/images/user.png"}",
          tag: "'#{self.id}'",
          url: "https://burnup.fr#{Rails.application.routes.url_helpers.notification_path(self)}"
        }

        debug_messages = []

        begin
          AppLogger.debug "Sending webpush to #{notified} with data #{notification_data}..."
          puts "Sending ... #{notification_data}"
          webpush_params = {
            message: JSON.generate(notification_data),
            endpoint: user_device.endpoint,
            p256dh: user_device.p256dh,
            auth: user_device.auth,
            ttl: 24 * 60 * 60
          }

          if user_device.vapid_enabled?
            webpush_params[:vapid] = {
              subject: "https://burnup.fr",
              public_key: Rails.application.secrets.VAPID_PUBLIC_KEY,
              private_key: Rails.application.secrets.VAPID_PRIVATE_KEY
            }
          else
            webpush_params[:api_key] = Rails.application.secrets.FIREBASE_API_KEY
          end

          w << Webpush.payload_send(webpush_params)
        rescue Webpush::InvalidSubscription => e
          debug_messages << "UserDevice##{user_device.id} for user##{notified.id} seems to be outdated "
          debug_messages << "setting it as expired to prevent to happen again ! "
          user_device.update_attribute(:expired, true)

          debug_messages << "Given Error message : #{e.message}"
          debug_messages << e.inspect

        rescue Exception => e
          debug_messages << "Could not send web push notification"
          debug_messages << "Given Error message : #{e.message}"
          debug_messages << e.inspect
        end

        if debug_messages.present?
          if Rails.env.development?
            debug_messages.each do |debug_message|
              puts debug_message
            end
          else
            debug_messages.each do |debug_message|
              AppLogger.debug debug_message
            end
          end
        end

      end
    end
    w
  end


end
