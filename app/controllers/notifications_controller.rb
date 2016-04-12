class NotificationsController < ApplicationController

  def index
    @notifications = current_user.received_notifications.unseen
    respond_to do |f|
      f.json
    end
  end

  def show
  end

  def destroy
  end
end
