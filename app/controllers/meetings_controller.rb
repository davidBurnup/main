class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  before_action :prepare_form, only: [:new, :edit]

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
    @meeting.meeting_users.build if @meeting and @meeting.meeting_users.empty?
    @meeting.practices.build if @meeting and @meeting.practices.empty?
  end

  # GET /meetings/1/edit
  def edit
    @meeting.meeting_users.build if @meeting and @meeting.meeting_users.empty?
    @meeting.practices.build if @meeting and @meeting.practices.empty?
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to meetings_path, notice: 'Meeting was successfully created.' }
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
        format.html { redirect_to meetings_path, notice: 'Meeting was successfully updated.' }
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
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
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

      @instruments = @users.first.instruments
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit([:start_at, :duration, :label, :practices_attributes => [:id, :start_at, :duration, :reminder, :_destroy], :meeting_users_attributes => [:id, :user_id, :instrument, :_destroy]])
    end
end
