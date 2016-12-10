
json.partial! "/api/shared/paginated_resource", name: :notification, items: @notifications, count: @count, page: @page, item_is_displayable: lambda {|notification|
  notification and notification.notifiable and notification.notifier
}
# json.array! @notifications do |notification|
#   if notification and notification.notifiable and notification.notifier
#     json.partial! 'notification', notification: notification
#   end
# end
