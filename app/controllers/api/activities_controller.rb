#encoding: utf-8
module Api
  class ActivitiesController < ApiController

    before_action :set_activity, only: [:show, :edit, :update, :destroy]
    skip_before_action :authorize_user, only: [:index, :show]

    # GET /api/activities
    # GET /api/activities.json
    def index
      @activities = PublicActivity::Activity.published

      if params[:recipient_type] and recipient_klass = params[:recipient_type].safe_constantize and r_id = params[:recipient_id] and @recipient = recipient_klass.find(r_id)
        @activities = @activities.on(@recipient)
      elsif current_user
        # This is user current feed !
        query_params = ['User', current_user.id]
        query = "(activities.recipient_type = ? AND activities.recipient_id = ?)"

        # Followed Pages
        if pages = current_user.followed_pages and pages.present?
          query += " OR (activities.recipient_type = ? AND activities.recipient_id IN (?))"
          query_params += ["Page"] + pages.collect(&:id)
        end

        @activities = @activities.where(query, *query_params)

      else
        head :bad_request # should not happen
      end
      @activities = @activities.order('updated_at DESC, created_at DESC').page(params[:page]).per(5)

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
