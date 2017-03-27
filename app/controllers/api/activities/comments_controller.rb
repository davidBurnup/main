module Api
  module Activities
    class CommentsController < Api::ApiController
      include ApiConfig
      before_action :set_activity, :set_comment, only: [:show, :edit, :update, :destroy]
      before_action :set_activity, only: [:create]
      # GET /api/activities/comments.json
      def index
        @comments = @activity.comments
      end

      # GET /api/activities/comments/1.json
      def show
      end

      # POST /api/activities/comments.json
      def create
        @comment = ::Comment.new(comment_params)
        @comment.commentable = @activity
        if !@comment.save!
          head :bad_request
        end
      end

      # PATCH/PUT /api/activities/comments/1.json
      def update
        if !@comment.update(comment_params)
          head :bad_request
        end
      end

      # DELETE /api/activities/comments/1
      # DELETE /api/activities/comments/1.json
      def destroy
        @comment.destroy
        respond_to do |format|
          format.json { head :no_content }
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_activity
          @activity = PublicActivity::Activity.find(params[:activity_id])
          unless @activity
            head :bad_request
          end
        end

        def set_comment
          @comment = @activity.comments.find(params[:id])
          unless @comment
            head :bad_request
          end
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def comment_params
          params.require(:comment).permit(:title, :comment)
        end
    end
  end
end
