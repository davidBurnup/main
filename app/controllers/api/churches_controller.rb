#encoding: utf-8
module Api
  class ChurchesController < ApiController

    skip_before_filter :authorize_user, only: [:index, :create]

    def index

      search_query ||= ""
      if params[:search]
        search_query = params[:search]
      end
      @churches = Church.where('churches.name LIKE ?', "%#{search_query}%").limit(3)
    end

    def create
      @church = Church.create(church_params)
      if @church.new_record?
        head :bad_request
      end
    end

    private

    def church_params
      params.require(:church).permit(:name)
    end

  end
end
