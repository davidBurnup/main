class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  before_action :prepare_form, only: [:new, :edit]

  # GET /meetings
  # GET /meetings.json
  def index

    if params[:meeting_id]
      @meeting = Meeting.find(params[:meeting_id])
    end

    respond_to do |f|
      f.json {
        @meetings = Meeting
        start_p = Time.parse(params[:start])
        end_p = Time.parse(params[:end])
        @meetings = @meetings.where("start_at > ?", params[:start])
        if start_p and end_p
          duration = end_p - start_p
          @meetings = @meetings.where("duration < ?", duration)
        end

        render :json => @meetings.map{|m|
          {
              :id => m.id,
              :title => m.label,
              :start => m.start_at,
              :end => m.end_at,
              :url => "/reunions/#{m.id}.js",
              color: '#D42700',
              textColor: 'white'
          }
        }
      }
      f.html
    end
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    respond_to do |f|
      f.html {redirect_to meetings_path(meeting_id: params[:id])}
      f.js {}
    end
    #@meeting = Meeting.find(params[:id])
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
    if params[:date]
      @meeting.start_at = Time.parse(params[:date])
    end
    # @meeting.meeting_users.build if @meeting and @meeting.meeting_users.empty?
    # @meeting.meeting_songs.build if @meeting and @meeting.meeting_songs.empty?
    @meeting.practice = Practice.new if @meeting and !@meeting.practice
  end

  # GET /meetings/1/edit
  def edit
    # @meeting.meeting_users.build if @meeting and @meeting.meeting_users.empty?
    # @meeting.meeting_songs.build if @meeting and @meeting.meeting_songs.empty?

    if @meeting and !@meeting.practice
      raise "Iin".inspect
      @meeting.practice = Practice.new
    end
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)
    respond_to do |format|
      if @meeting.save
        format.html { redirect_to meetings_path, notice: 'La réunion a bien été ajoutée.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to meetings_path, notice: 'La réunion a bien été modifiée.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'La réunion a bien été détruite.' }
      format.json { head :no_content }
    end
  end

  private

    def prepare_form
      if current_user.church
          @users = current_user.church.users
      else
          @users = User.all
      end

      @leader_users = User.leaders

      @instruments = @users.first.instruments
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit([:start_at, :duration, :label, songs: [], :practice_attributes => [:id, :start_at, :duration, :reminder, :_destroy], :meeting_users_attributes => [:id, :user_id, :is_leader, :instrument, :_destroy], :meeting_songs_attributes => [:id, :leader_id, :song_id, :_destroy]])
    end
end
