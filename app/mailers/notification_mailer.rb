class NotificationMailer < ApplicationMailer
  helper MailerHelper
  helper NotificationsHelper
  def notify(notification)
    @notification = notification
    if @notification and @notified = @notification.notified and @notifier = @notification.notifier

      inline_images = %w( logov2.jpg facebook.png googleplus.png twitter.png blurb_01.png )
      prepare_inline_static_images(inline_images)

      attachments.inline['notifier_avatar'] = File.read( @notifier.avatar.path(:thumb))
      mail(to: @notified.email, subject: "Vous avez une nouvelle notification de #{@notified.full_name} sur Burnup !")
    end
  end

  def prepare_inline_static_images(inline_images)
    inline_images.each do |inline_image|
      attachments.inline[inline_image] = File.read(Rails.root.join('app', 'assets', 'images', 'email', inline_image))
    end
  end

end
