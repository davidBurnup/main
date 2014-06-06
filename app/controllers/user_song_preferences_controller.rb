class UserSongPreferencesController < ApplicationController
  before_action :set_user_song_preference, only: [:show, :edit, :update, :destroy]

  # GET /user_song_preferences
  # GET /user_song_preferences.json
  def index
    @user_song_preferences = UserSongPreference.all
  end

  # GET /user_song_preferences/1
  # GET /user_song_preferences/1.json
  def show
  end

  # GET /user_song_preferences/new
  def new
    @user_song_preference = UserSongPreference.new
  end

  # GET /user_song_preferences/1/edit
  def edit
  end

  # POST /user_song_preferences
  # POST /user_song_preferences.json
  def create
    @user_song_preference = UserSongPreference.new(user_song_preference_params)

    respond_to do |format|
      if @user_song_preference.save
        format.html { redirect_to @user_song_preference, notice: 'User song preference was successfully created.' }
        format.json { render :show, status: :created, location: @user_song_preference }
      else
        format.html { render :new }
        format.json { render json: @user_song_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_song_preferences/1
  # PATCH/PUT /user_song_preferences/1.json
  def update

    respond_to do |format|
      if @user_song_preference.update(user_song_preference_params)
        format.html { redirect_to @user_song_preference, notice: 'User song preference was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_song_preference }
        format.js {}
      else
        format.html { render :edit }
        format.json { render json: @user_song_preference.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # DELETE /user_song_preferences/1
  # DELETE /user_song_preferences/1.json
  def destroy
    @user_song_preference.destroy
    respond_to do |format|
      format.html { redirect_to user_song_preferences_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_song_preference
      @user_song_preference = UserSongPreference.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_song_preference_params
      params.require(:user_song_preference).permit(:prefered_key)
    end
end
