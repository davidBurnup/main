class ActivitiesController < ApplicationController

  def index
    @post = Post.new
    @post.music_medias.build
  end

end
