#encoding: utf-8
module Api
  class NotificationsController < ApiController
    def index
      @page = params[:page] || 1
      @notifications = current_user.received_notifications.joins(:notified).joins(:notifier).where('notifications.notified_id IS NOT NULL AND notifications.notifier_id IS NOT NULL').unseen.order('notifications.updated_at DESC').page(@page).per_page(10)
      @count = @notifications.total_entries
    end
  end
end
