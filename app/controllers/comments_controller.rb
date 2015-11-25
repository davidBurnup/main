class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment }
        format.js {}
        format.json { render :show, status: :created, location: @comment }
      else
        format.js {}
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy

    @comment = Comment.find(params[:id])

    authorize @comment, :destroy?

    if @comment
      @destroyed_id = @comment.id
      @was_destroyed = @comment.destroy
    end

    respond_to do |f|
      f.js {}
    end

  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:comment, :commentable_id, :commentable_type)
  end

end
