#encoding: utf-8
module Api
  class NotificationsController < ApiController

    before_action :set_notification, only: [:update, :destroy]
    def index
      @page = params[:page] || 1
      @notifications = current_user.received_notifications.joins(:notified).joins(:notifier).where('notifications.notified_id IS NOT NULL AND notifications.notifier_id IS NOT NULL')
      @unseen_count = @notifications.unseen.count
      @notifications = @notifications.order('notifications.updated_at DESC').page(@page).per_page(10)
      @count = @notifications.total_entries
    end

    def update
      respond_to do |f|
        f.json {
          if @notification.update(notification_params)
            head :ok
          else
            head :bad_request
          end
        }
      end
    end

    def destroy

      respond_to do |f|
        f.json {
          if @notification.destroy
            head :ok
          else
            head :bad_request
          end
        }
      end
    end

    private

    def set_notification
      @notification = Notification.find(params[:id])
      unless @notification.present?
        head :bad_request
      end
    end

    def notification_params
      params.require(:notification).permit(:id, :is_seen)
    end
  end
end
