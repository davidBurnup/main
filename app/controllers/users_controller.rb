class UsersController < ApplicationController
  before_action :set_user, only: [:show, :instruments, :update, :destroy, :unfinalized]
  after_action :verify_authorized, except: [:show, :instruments]
  skip_before_action :unfinalized_callback, only: :unfinalized
  def index
    @users = User.all
    authorize @users
  end

  def show

    @user ||= current_user

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
      f.json {
        if @user
          render json: {
            id: @user.id,
            email: @user.email
          }.to_json
        else
          render json: {}
        end
      }
    end
    #unless current_user.admin?
    #  unless @user == current_user
    #    redirect_to root_path, :alert => "Access denied."
    #  end
    #end
  end

  def instruments
    @instruments = []
    @instruments = @user.instruments if user
    respond_to do |f|
      f.json {

      }
    end
  end

  def update

    authorize @user
    @user.attributes = secure_params
    if @user.save(validate: false)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    authorize @user
    unless @user == current_user
      @user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  def unfinalized
    authorize @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def secure_params
    params.require(:user).permit(:first_name, :last_name, :role, :page, :page_role_attributes => [:id, :role, :user_id, :page_id ])
  end

end
