notification ||= nil

if notification
  json.id notification.id
  json.notifier do
    json.full_name notification.notifier.full_name
    json.avatar do
      json.url do
        json.micro notification.notifier.avatar.url(:micro)
        json.mini notification.notifier.avatar.url(:mini)
      end
    end
  end

  json.header_content build_notification_header(notification)
  json.notifiable_content notification.notifiable.notifiable_content
  json.notified_at l(notification.updated_at)
end
