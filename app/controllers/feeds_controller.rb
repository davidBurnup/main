class FeedsController < ApplicationController
  def index
    @activities = PublicActivity::Activity.paginate(page: params[:page], per_page: 15).order('created_at DESC')

    respond_to do |f|
      f.html
      f.js
    end
  end
end
