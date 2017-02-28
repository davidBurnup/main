#encoding: utf-8
module Api
  class UsersController < ApiController

    skip_before_filter :authorize_user, only: [:create]

    before_action :set_user, only: [:update, :toggle_like]

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
      params.require(:user).permit(:church_id, :avatar, :is_finalized)
    end
  end
end
