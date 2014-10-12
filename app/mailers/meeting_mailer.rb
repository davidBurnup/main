class MeetingMailer < ActionMailer::Base
  default from: "burnup@ac-ac.fr"

  def notify_practice(meeting_user)
    @user = meeting_user.user
    @meeting = meeting_user.meeting
    if @user and @user.email and @meeting
      attachments.inline['logo_mini4.svg'] = File.read(Rails.root.join('app', 'assets', 'images', 'logo_mini4.svg'))
      file_path = @user.avatar.path(:med_tiny)
      @user_pic = File.basename(file_path)
      attachments.inline[@user_pic] = File.read(file_path)
      mail(to: @user.email, subject: "Réunion \"#{@meeting.label}\" pour le #{@meeting.start_at.strftime("%d/%m/%Y à %H:%M")}" )
    end
  end
end
