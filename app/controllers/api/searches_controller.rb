module Api
  class SearchesController < Api::ApiController
    include ApiConfig

    # POST /posts
    # POST /posts.json
    def index
      if term = params[:term] and term.present?
        searched_classes = ['Page', 'Song']

        if params[:classes] and classes = params[:classes].split(",")
          searched_classes = searched_classes & classes
        end

        if searched_classes.present?
          searched_classes = searched_classes.collect(&:safe_constantize).compact.uniq
        end

        # Page.search("Prem", fields: [:name], match: :word_start).first
        # @results = Searchkick.search(term, fields: [:name, :title, :content], index_name: searched_classes, match: :word_start)
      end
    end

    private

      # Never trust parameters from the scary internet, only allow the white list through.
      # def media_params
      #   params.require(:media).permit(:id, :attachment, :image, :pdf, :word, :excel, :post_id, :audio, :video, :poster_image)
      # end
  end
end
