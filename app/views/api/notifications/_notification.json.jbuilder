notification ||= nil
pre_loaded_current_user ||= current_user

if notification and pre_loaded_current_user
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

  json.header_content build_notification_header(notification, pre_loaded_current_user)
  json.notifiable_content notification.notifiable.notifiable_content
  json.notified_at l(notification.updated_at)
end
