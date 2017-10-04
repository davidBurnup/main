class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, :except => [:show, :attach]
  skip_before_action :authorize_user, only: [:show]
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all
    authorize @pages
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
    authorize @page
  end

  # GET /pages/1/edit
  def edit
    authorize @page
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    authorize @page
    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    authorize @page
    respond_to do |format|
      if @page.update(page_params)
        format.html {
          flash[:notice] = "Votre page a bien été sauvegardé."
          render :edit
        }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html {
          render :edit, error: @page.errors
        }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    authorize @page
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.where(slug: params[:id]).first
      unless @page
        flash[:error] = "Cette page n'existe"
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:name, :is_valid, :logo, :avatar, :address, :slogan, :description, :youtube_video_id, :background_image, :youtube_url, :facebook_url, :twitter_url, :patreon_url)
    end
end
