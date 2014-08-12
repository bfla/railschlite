class DestinationsController < ApplicationController
  before_action :set_destination, only: [:show, :edit, :update, :destroy]
  before_action :verify_admin, except: [:index, :show]

  # GET /destinations
  # GET /destinations.json
  def index
    @destinations = Destination.page(params[:page]).per(50)
  end

  # GET /destinations/1
  # GET /destinations/1.json
  def show
  end

  # GET /destinations/new
  def new
    @destination = Destination.new
  end

  # GET /destinations/1/edit
  def edit
  end

  # POST /destinations
  # POST /destinations.json
  def create
    @destination = Destination.new(destination_params)

    respond_to do |format|
      if @destination.save
        format.html { redirect_to @destination, notice: 'Destination was successfully created.' }
        format.json { render action: 'show', status: :created, location: @destination }
      else
        format.html { render action: 'new' }
        format.json { render json: @destination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /destinations/1
  # PATCH/PUT /destinations/1.json
  def update
    respond_to do |format|
      if @destination.update(destination_params)
        format.html { redirect_to @destination, notice: 'Destination was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @destination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /destinations/1
  # DELETE /destinations/1.json
  def destroy
    @destination.destroy
    respond_to do |format|
      format.html { redirect_to destinations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_destination
      @destination = Destination.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def destination_params
      params.require(:destination).permit(:state_id, :name, :description, :latitude, :longitude, :zoom, :radius, :slug, :highlights, :things_to_do, :camping_tips, :file, :page)
    end
end
