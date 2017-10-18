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
        else
          if @activity.trackable
            case @activity.trackable.class.to_s
            when "Song"
              @meta_fb_type = "music.song"
              @meta_description = @activity.trackable.content
              @meta_title = @activity.trackable.title
            when "Post"
              @meta_fb_type = "article"
              @meta_title = @activity.trackable.content.truncate(30)
              @meta_description = @activity.trackable.content
              if video_url = @activity.trackable.content[/((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?/]
                @meta_video = video_url
              end
            end
          end
	  		end
  		}
  	end
  end

end
