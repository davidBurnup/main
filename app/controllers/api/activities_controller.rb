#encoding: utf-8
module Api
  class ActivitiesController < ApiController

    before_action :set_activity, only: [:show, :edit, :update, :destroy]
    skip_before_filter :authorize_user, only: [:index]
    # GET /api/activities
    # GET /api/activities.json
    def index
      @activities = PublicActivity::Activity.published

      if params[:recipient_type] and recipient_klass = params[:recipient_type].safe_constantize and r_id = params[:recipient_id] and @recipient = recipient_klass.find(r_id)
        @activities = @activities.on(@recipient)
      end
      @activities = @activities.order('updated_at DESC, created_at DESC').paginate(page: params[:page], per_page: 5)

      authorize @activities
    end

    # GET /api/activities/1
    # GET /api/activities/1.json
    def show
    end

    # GET /api/activities/new
    def new
      @activity = PublicActivity::Activity.new
    end

    # GET /api/activities/1/edit
    def edit
    end

    # POST /api/activities
    # POST /api/activities.json
    def create
      @activity = PublicActivity::Activity.new(activity_params)

      respond_to do |format|
        if @activity.save
          format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
          format.json { render :show, status: :created, location: @activity }
        else
          format.html { render :new }
          format.json { render json: @activity.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /api/activities/1
    # PATCH/PUT /api/activities/1.json
    def update
      respond_to do |format|
        if @activity.update(activity_params)
          format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
          format.json { render :show, status: :ok, location: @activity }
        else
          format.html { render :edit }
          format.json { render json: @activity.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /api/activities/1
    # DELETE /api/activities/1.json
    def destroy
      @activity.destroy
      respond_to do |format|
        format.html { redirect_to api_activities_url, notice: 'Activity was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_activity
        @activity = PublicActivity::Activity.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def activity_params
        params[:activity]
      end
  end
end
