class ChurchesController < ApplicationController
  before_action :set_church, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, :except => [:show, :attach]

  # GET /churches
  # GET /churches.json
  def index
    @churches = Church.all
    authorize @churches
  end

  # GET /churches/1
  # GET /churches/1.json
  def show
  end

  # GET /churches/new
  def new
    @church = Church.new
    authorize @church
  end

  # GET /churches/1/edit
  def edit
    authorize @church
  end

  # POST /churches
  # POST /churches.json
  def create
    @church = Church.new(church_params)
    authorize @church
    respond_to do |format|
      if @church.save
        format.html { redirect_to @church, notice: 'Church was successfully created.' }
        format.json { render :show, status: :created, location: @church }
      else
        format.html { render :new }
        format.json { render json: @church.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /churches/1
  # PATCH/PUT /churches/1.json
  def update
    authorize @church
    respond_to do |format|
      if @church.update(church_params)
        format.html { redirect_to @church, notice: 'Church was successfully updated.' }
        format.json { render :show, status: :ok, location: @church }
      else
        format.html { render :edit }
        format.json { render json: @church.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /churches/1
  # DELETE /churches/1.json
  def destroy
    authorize @church
    @church.destroy
    respond_to do |format|
      format.html { redirect_to churches_url, notice: 'Church was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_church
      @church = Church.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def church_params
      params.require(:church).permit(:name, :is_valid, :logo, :address, :slogan)
    end
end
