class CampsitesController < ApplicationController
  before_action :set_campsite, only: [:edit, :update, :destroy]
  before_action :verify_admin, except: [:show, :index]

  # GET /campsites
  # GET /campsites.json
  def index
    @campsites = Campsite.page(params[:page]).per(50)
  end

  # GET /campsites/1
  # GET /campsites/1.json
  def show
    @campsite = Campsite.includes(:city, :state).friendly.find(params[:id])
    @nearbys = @campsite.nearbys.limit(10)
    gon.initCenter = [@campsite.latitude, @campsite.longitude]
    gon.geoJson = @campsite.to_geojson
  end

  # GET /campsites/new
  def new
    @campsite = Campsite.new
  end

  # GET /campsites/1/edit
  def edit
  end

  # POST /campsites
  # POST /campsites.json
  def create
    @campsite = Campsite.new(campsite_params)

    respond_to do |format|
      if @campsite.save
        format.html { redirect_to @campsite, notice: 'Campsite was successfully created.' }
        format.json { render action: 'show', status: :created, location: @campsite }
      else
        format.html { render action: 'new' }
        format.json { render json: @campsite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campsites/1
  # PATCH/PUT /campsites/1.json
  def update
    respond_to do |format|
      if @campsite.update(campsite_params)
        format.html { redirect_to @campsite, notice: 'Campsite was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @campsite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campsites/1
  # DELETE /campsites/1.json
  def destroy
    @campsite.destroy
    respond_to do |format|
      format.html { redirect_to campsites_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campsite
      @campsite = Campsite.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campsite_params
      params.require(:campsite).permit(:name, :state_abbrev, :latitude, :longitude, :elevation, :phone, :total_sites, :electric_sites, :outhouse, :showers, :dump, :page, :lead_phto)
    end
end
