json.array! @notifications do |notification|
  if notification and notification.notifiable and notification.notifier
    json.partial! 'notifications/notification', notification: notification
  end
end
