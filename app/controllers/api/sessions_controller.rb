#encoding: utf-8
module Api
  class SessionsController < Devise::SessionsController

    include ApiConfig

    respond_to :json

    skip_before_action :authorize_user, only: [:create]

    # POST /resource/sign_in
    def create
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :remember_me)
    end

  end
end
