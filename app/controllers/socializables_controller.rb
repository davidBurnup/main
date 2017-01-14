class SocializablesController < ApplicationController

  after_action :verify_authorized, :except => [:like, :action]

  def index
    @activities = PublicActivity::Activity.all.paginate(page: params[:page], per_page: 5).order('created_at DESC')
    authorize @activities
    @post = Post.new
    @post.music_medias.build

    respond_to do |f|
      f.html
      f.js
    end
  end

  def show
    @activity = PublicActivity::Activity.find(params[:id])
    authorize @activity, :show?
    respond_to do |f|
      f.html {
        unless @activity
          flash[:error] = "Ce actualité n'existe pas !"
          redirect_to root_path
        end
      }
    end
  end

  def like
    likable_type = params[:likable_type]
    likable_id = params[:likable_id]

    if likable_type and likable_id and current_user
      likable_class = likable_type.camelize.constantize
      if likable_class
        @likable = likable_class.where(id: likable_id).first
        if @likable
          current_user.toggle_like!(@likable)
        end
      end
    end
  end

  def action

  end

  def destroy

    @activity = PublicActivity::Activity.find(params[:id])

    authorize @activity, :destroy?

    if @activity
      @destroyed_id = @activity.id
      @was_destroyed = @activity.destroy
    end

    respond_to do |f|
      f.js {}
    end

  end

end
