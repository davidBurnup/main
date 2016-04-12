class NotificationsChannel < ApplicationCable::Channel
  def notification_subscribed(data)
    stop_all_streams
    stream_from "notifications-for-user-#{data['user_id']}"
  end
end
