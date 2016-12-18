class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show]

  # GET /notifications/1
  def show
    @notification.set_as_seen!

    # Redirect to root activity show path
    if @notification.notifiable and @notification.notifiable.root_activity
      redirect_to show_activity_path(@notification.notifiable.root_activity)
    end
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
    if !@notification
      flash[:error] = "Cette notification n'existe plus."
      redirect_to root_path
    end
  end

end
