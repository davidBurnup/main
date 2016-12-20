class NotificationMailer < ApplicationMailer
  helper MailerHelper
  helper NotificationsHelper
  default from: "burnup@ac-ac.fr"
  def notify(notification)
    @notification = notification
    if @notification and @notified = @notification.notified and @notifier = @notification.notifier

      inline_images = %w( logov2.jpg facebook.png googleplus.png twitter.png )
      prepare_inline_static_images(inline_images)

      if @notifier.avatar.present?
        attachments.inline['notifier_avatar'] = File.read( @notifier.avatar.path(:thumb))
      else
        attachments.inline['notifier_avatar'] = File.read( Rails.root.join('public', 'images', 'thumb', 'user.png'))
      end

      mail(to: @notified.email, subject: "Vous avez une nouvelle notification de #{@notified.full_name} sur Burnup !")
    end
  end

  def prepare_inline_static_images(inline_images)
    inline_images.each do |inline_image|
      attachments.inline[inline_image] = File.read(Rails.root.join('app', 'assets', 'images', 'email', inline_image))
    end
  end

end
