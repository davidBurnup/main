class MessagesWorker
  include Sidekiq::Worker

  def perform(meeting_id)
    meeting = Meeting.where(id: meeting_id).first
    if meeting
      meeting.notify_practice
    end
  end
end