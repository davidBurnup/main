class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  include Pundit
  include Devise::Controllers::Helpers

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session

  before_action :authorize_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  def after_sign_out_path(resource)
    new_user_session_path
  end

  def set_current_user
    User.current = current_user
  end

  private

  def authorize_user
    authenticate_user!
    self.set_current_user
  end
  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas autorisé à faire cette action."
    redirect_to (request.referrer || root_path)
  end



end
