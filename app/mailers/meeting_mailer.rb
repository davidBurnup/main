class MeetingMailer < ActionMailer::Base
  default from: "burnup@ac-ac.fr"

  def notify_practice(meeting_user)
    @user = meeting_user.user
    @meeting = meeting_user.meeting
    if @user and @user.email and @meeting
      attachments.inline['logo_mini4.svg'] = File.read('/assets/logo_mini4.svg')
      attachments.inline['user_pic'] = File.read(@uesr.avatar.url(:med_tiny))
      mail(to: @user.email, subject: "Réunion \"#{@meeting.label}\" pour le #{@meeting.start_at.strftime("%d/%m/%Y à %H:%M")}" )
    end
  end
end
