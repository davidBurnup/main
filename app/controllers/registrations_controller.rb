class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?
  layout :resolve_layout

  def new
    redirect_to root_path(anchor: "sign-in")
  end

  def update_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation, :page_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :name, :email, :page_id, :password, :password_confirmation, :current_password, :avatar])
  end

  def after_inactive_sign_up_path_for(resource)
    flash.keep(:alert)
    flash.keep(:notice)
    new_user_session_path
  end

  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  def password
    @user = User.find(current_user.id)
  end

  def update_password
    @user = User.find(current_user.id)
    respond_to do |f|
      f.html {
        if @user.update_with_password(user_params)
          flash[:success] = "Votre mot de passe a bien été modifié."
        else
          #flash[:error] = "Une erreur s'est produite."
        end
        render :password
      }
    end
  end

  def instruments
    @user = User.find(current_user.id)
  end

  def update_instruments
    @user = User.find(current_user.id)
    respond_to do |f|
      f.html {
        if @user.update(instruments_params)
          flash[:success] = "La liste de vos instruments a bien été modifiée."
        else
          #flash[:error] = "Une erreur s'est produite."
        end
        render :instruments
      }
    end
  end

  private

  def resolve_layout
    case action_name
      when "edit", "update", "password", "update_password", "instruments", "update_instruments"
        "application"
      else
        "public"
    end
  end

  def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation, :page_id)
  end

  def instruments_params
    params.require(:user).permit(instrument_preferences_attributes: [:id, :instrument, :detail, :_destroy])
  end

end
