class Api::InstrumentPreferencesController < Api::ApiController

  before_action :set_instrument_preference, only: [:show, :edit, :update, :destroy]

  # GET /api/instruments.json
  def index
    @instrument_preferences = InstrumentPreference.for_user(current_user)
  end

  # GET /api/instruments/1.json
  def show
  end

  # POST /api/instruments.json
  def create
    @instrument_preference = InstrumentPreference.new(instrument_preference_params)

    respond_to do |format|
      if @instrument_preference.save
        format.json { render :show, status: :created, location: api_instrument_preference_url(@instrument_preference) }
      else
        format.json { render json: @instrument_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/instruments/1.json
  def update
    respond_to do |format|
      if @instrument_preference.update(instrument_preference_params)
        format.json { render :show, status: :ok, location: @instrument_preference }
      else
        format.json { render json: @instrument_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/instruments/1.json
  def destroy
    @instrument_preference.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instrument_preference
      @instrument_preference = InstrumentPreference.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instrument_preference_params
      params.require(:instrument_preference).permit(:detail, :instrument, :user_id)
    end
end
