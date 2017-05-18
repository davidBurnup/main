module Api
  class MediasController < Api::ApiController
    include ApiConfig

    # POST /posts
    # POST /posts.json
    def create
      m_params = media_params

      # Detect file content type and set correct attachment type
      att = m_params[:attachment]
      if att = m_params[:attachment] and att_type = Media.detect_attachment_type(att.content_type)
        m_params[att_type] = att
      end
      m_params.delete :attachment

      @media = Media.new(m_params)

      if !@media.save
        head :bad_request
      end
    end

    # DELETE /posts/1
    # DELETE /posts/1.json
    def destroy
      @media = Media.find(params[:id])
      unless @media
        head :bad_request
      end
      @media.destroy
      respond_to do |format|
        format.json { head :no_content }
      end
    end

    private

      # Never trust parameters from the scary internet, only allow the white list through.
      def media_params
        params.require(:media).permit(:id, :attachment, :image, :pdf, :word, :excel, :post_id)
      end
  end
end
