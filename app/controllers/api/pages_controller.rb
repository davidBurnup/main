#encoding: utf-8
module Api
  class PagesController < ApiController

    skip_before_action :authorize_user, only: [:index, :create, :show]
    before_action :set_page, only: [:show, :update]

    def index

      search_query ||= ""
      if params[:search]
        search_query = params[:search]
      end
      @pages = Page.where('pages.name LIKE ?', "%#{search_query}%").valid_for(current_user).limit(3)
    end

    def create
      @page = Page.create(page_params)
      if @page.new_record?
        head :bad_request
      end
    end

    def show
      @page
    end

    def update
      if p = params[:page] and !p[:is_followed].nil? and current_user and !@page.is_admin?(current_user)
        if p[:is_followed] and !@page.is_followed_by?(current_user)
          @page.follow!(current_user)
        else
          @page.unfollow!(current_user)
        end
      end
    end

    private

    def set_page
      @page = Page.find(params[:id])
      if !@page
        head :bad_request
      end
    end

    def page_params
      params.require(:page).permit(:name, :slogan, :description)
    end

  end
end
