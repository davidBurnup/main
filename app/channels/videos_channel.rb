class VideosChannel < ApplicationCable::Channel
  def videos_subscribed(data)
    stop_all_streams
    puts "video-progress-#{data['media_id']}"
    stream_from "video-progress-#{data['media_id']}"
  end
end
