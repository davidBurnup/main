class SongsController < ApplicationController

  before_action :set_page, only: [:index]
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized
  skip_before_action :authorize_user, only: [:show]

  # GET /songs
  # GET /songs.json
  def index

    # @enable_search = {
    #     :search_domain => [:songs],
    #     :path => songs_search_path
    # }
    # @any_search_term = ""

    @songs = Song.order(:title => :asc)

    if @page
      @songs = @songs.where(origin_page_id: @page.id)
    end

    @song = @songs.first || Song.new
    if params[:search_term].present?
      @any_search_term = params[:search_term]
      search_query = "%#{@any_search_term}%"
      # OR MATCH(clean_content) AGAINST (?)
      @songs = @songs.where('songs.title LIKE ?', search_query)
    end

    authorize @songs
  end

  # GET /songs/1
  # GET /songs/1.json
  def show

    song_posts = @song.posts
    @post_activities = PublicActivity::Activity.where(:trackable_type => "Post", :trackable_id => song_posts.collect(&:id)).page(params[:page]).per(15).order('created_at DESC')
    @post = Post.new
    @post.song = @song
    # @post.music_medias.build

    authorize @song
  end

  # GET /songs/new
  def new
    @song = Song.new
    is_authorized = authorize @song
    render :edit if is_authorized
  end

  # GET /songs/1/edit
  def edit
    authorize @song
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)
    authorize @song
    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Le chant a bien été enregistré.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    authorize @song
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Le chant a bien été enregistré.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    authorize @song
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    def set_page
      @page = Page.where(slug: params[:page_id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:title, :content, :key, :author, :bpm, :origin_page_id)
    end
end
