class MeetingMailer < ActionMailer::Base
  default from: "burnup@ac-ac.fr"

  def notify_practice(meeting_user)
    @user = meeting_user.user
    @meeting = meeting_user.meeting
    if @user and @user.email and @meeting
      mail(to: @user.email, subject: "Réunion \"#{@meeting.label}\" pour le #{@meeting.start_at.strftime("%d/%m/%Y à %H:%M")}" )
    end
  end
end
