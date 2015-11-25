class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized, except: [:show, :instruments]

  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])

    any_filter = params[:filter]

    if any_filter
      case any_filter
        when "instruments"
          @user = @user.instruments
      end
    end

    respond_to do |f|
      f.html
      f.js {
      }
    end
    #unless current_user.admin?
    #  unless @user == current_user
    #    redirect_to root_path, :alert => "Access denied."
    #  end
    #end
  end

  def instruments
    user = User.find(params[:id])
    @instruments = []
    @instruments = user.instruments if user
    respond_to do |f|
      f.json {

      }
    end
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    @user.attributes = secure_params
    if @user.save(validate: false)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  private

  def secure_params
    params.require(:user).permit(:first_name, :last_name, :role, :church, :church_role_attributes => [:id, :role, :user_id, :church_id ])
  end

end
