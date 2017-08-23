module Api
  class PostsController < Api::ApiController
    include ApiConfig

    before_action :prepare_params, only: [:create, :update]
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    # GET /posts/1.json
    def show
    end

    # POST /posts
    # POST /posts.json
    def create
      if @prepared_post_params and @prepared_post_params[:is_draft]
        @post = Post.where(is_draft: true, user_id: current_user.id).first
        # raise @post.inspect
      end
      if !@post
        @post = Post.new(@prepared_post_params)
      end

      @post.user = current_user

      respond_to do |format|
        if @post.save_with_activity(@recipient)
          format.json { render :show, status: :created, location: @post }
        else
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /posts/1
    # PATCH/PUT /posts/1.json
    def update
      @post.assign_attributes(@prepared_post_params)
      respond_to do |format|
        if @post.save_with_activity(@recipient)
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
        params.require(:post).permit(:content, :user_id, :song_id, :external_url, :is_draft, :recipient_type, :recipient_id)
      end

      def prepare_params
        @prepared_post_params = post_params
        if r_klass = @prepared_post_params[:recipient_type] and r_klass = r_klass.safe_constantize and r_id = @prepared_post_params[:recipient_id] and @recipient = r_klass.find(r_id)

        elsif current_user
          @recipient = current_user
        else
          head :bad_request          
        end
        @prepared_post_params.delete :recipient_type
        @prepared_post_params.delete :recipient_id
      end
  end
end
