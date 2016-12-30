#encoding: utf-8
module Api
  class UsersController < ApiController

    skip_before_filter :authorize_user, only: [:create]

    def create
      @user = User.create(user_params)
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
  end
end
