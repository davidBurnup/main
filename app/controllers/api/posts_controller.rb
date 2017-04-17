module Api
  class PostsController < Api::ApiController
    include ApiConfig
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    # GET /posts/1.json
    def show
    end

    # POST /posts
    # POST /posts.json
    def create
      @post = Post.new(post_params)
      @post.user = current_user
      @post.remove_blank_music_medias

      respond_to do |format|
        if @post.save
          format.json { render :show, status: :created, location: @post }
        else
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /posts/1
    # PATCH/PUT /posts/1.json
    def update
      respond_to do |format|
        if @post.update(post_params)
          format.json { render :show, status: :ok, location: @post }
        else
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /posts/1
    # DELETE /posts/1.json
    def destroy
      @post.destroy
      respond_to do |format|
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def post_params
        params.require(:post).permit(:content, :user_id, :song_id, :external_url, :music_medias_attributes => [:attachment])
      end
  end
end
