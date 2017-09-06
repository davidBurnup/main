class ActivitiesController < ApplicationController

  skip_before_action :authorize_user, only: [:show]
  
  def index
    @post = Post.new
  end

  def show
  	@activity = PublicActivity::Activity.where(id: params[:id]).first

  	respond_to do |f|
  		f.html {
  			unless @activity.present? or (@activity and @activity.recipient.blank?)
	  			flash[:error] = "Cette actualité n'existe plus !"
	  			redirect_to root_path
	  		end
  		}
  	end
  end

end
