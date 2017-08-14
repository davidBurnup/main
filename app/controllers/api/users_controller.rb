#encoding: utf-8
module Api
  class UsersController < ApiController

    skip_before_filter :authorize_user, only: [:create]

    before_action :set_user, only: [:update, :toggle_like, :push_subscribe, :push_unsubscribe]

    def current

    end
      
    def create
      @user = User.create(create_user_params)
    end

    def update
      @user.update(update_user_params)
      if @user.new_record?
        head :bad_request
      end
    end

    def toggle_like
      activity_id = params[:activity_id]

      if activity_id and current_user
        @activity = PublicActivity::Activity.where(id: activity_id).first
        if @activity
          @was_saved = current_user.toggle_like!(@activity)
        end
      end

      if !@activity
        head :bad_request
      end
    end

    def push_unsubscribe
      if @user and e = params[:endpoint] and @found_device = @user.user_devices.where(endpoint: e).first
        if @found_device.destroy
          head :ok
        else
          head :bad_request
        end
      else
        head :bad_request
      end
    end

    def push_subscribe
      # Required params for registereing a device for push notifications are :
      # => params[:subscription][:keys][:auth] (sort of key)
      # => params[:subscription][:keys][:p256dh] (sort of secret)
      # => params[:subscription][:endpoint] (url to point to)
      # User Devices are matched by endpoints
      if params[:subscription] and endpoint = params[:subscription][:endpoint] and params[:subscription][:keys] and p256dh = params[:subscription][:keys][:p256dh] and auth = params[:subscription][:keys][:auth]
        @found_device = @user.user_devices.where(endpoint: params[:subscription][:endpoint]).first
        if @found_device
          @found_device.update({
              endpoint: endpoint,
              auth: auth,
              p256dh: p256dh,
              vapid_enabled: params[:vapid_enabled]
            })
        else
          UserDevice.create({
            user_id: @user.id,
            endpoint: endpoint,
            auth: auth,
            p256dh: p256dh,
            vapid_enabled: params[:vapid_enabled]
          })
        end
      else
        head :bad_request
      end

      head :ok
    end

    private

    def set_user
      @user = User.find(params[:id])
      unless @user.present?
        head :bad_request
      end
    end

    def create_user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

    def update_user_params
      params.require(:user).permit(:page_id, :avatar, :is_finalized)
    end
  end
end
