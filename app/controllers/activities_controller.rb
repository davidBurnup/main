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
            if @activity.recipient.class.to_s == Page
              @meta_image = @activity.recipient.logo.url
            end

            case @activity.trackable.class.to_s
            when "Song"
              @meta_fb_type = "music.song"
              @meta_description = @activity.trackable.content
              @meta_title = @activity.trackable.title
            when "Post"
              @meta_fb_type = "article"
              @meta_title = @activity.trackable.content.truncate(30)
              @meta_description = @activity.trackable.content

              youtube_regex = /((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?/
              if video_url_matches = @activity.trackable.content.match(youtube_regex) and video_url_matches.present?
                # @meta_video = video_url_matches[0]
                if video_url_matches[5]
                  @meta_image = "https://img.youtube.com/vi/#{video_url_matches[5]}/hqdefault.jpg"
                end
              end

              @post = @activity.trackable
              if @post.medias.count > 0 and @post.medias.where.not(video_file_name: nil).count > 0
                any_video_media = @post.medias.where.not(video_file_name: nil).first
                @meta_video = "#{request.base_url}#{any_video_media.video.url}"
                @meta_image = nil
              end

            end
          end
	  		end
  		}
  	end
  end

end
