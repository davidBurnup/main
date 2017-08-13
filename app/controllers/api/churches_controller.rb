#encoding: utf-8
module Api
  class ChurchesController < ApiController

    skip_before_filter :authorize_user, only: [:index, :create]
    before_action :set_church, only: [:show]

    def index

      search_query ||= ""
      if params[:search]
        search_query = params[:search]
      end
      @churches = Church.where('churches.name LIKE ?', "%#{search_query}%").valid_for(current_user).limit(3)
    end

    def create
      @church = Church.create(church_params)
      if @church.new_record?
        head :bad_request
      end
    end

    def show
      @church
    end

    private

    def set_church
      @church = Church.find(params[:id])
      if !@church
        head :bad_request
      end
    end

    def church_params
      params.require(:church).permit(:name, :slogan)
    end

  end
end
