class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]
  before_action :verify_admin, except:[:show, :index, :browse]

  # GET /cities
  # GET /cities.json
  def index
    @cities = City.page(params[:page]).per(50)
  end

  def browse
    @city = City.includes(:campsites, :state).friendly.find(params[:id])
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
    @city = City.includes(:campsites, :state).friendly.find(params[:id])
    # Get nearby cities but exclude the @city
    @nearby_cities = City.near([@city.latitude, @city.longitude], 40).where.not(id:@city.id).first(4)
    # Get nearby campsites but exclude campsites in the @city
    @nearby_campsites = Campsite.near([@city.latitude, @city.longitude], 40).where.not(city_id:@city.id)
    #@nearby_campsites.each_with_index {|cg, index| @nearby_cities.delete_at(index) if cg.city_id == @city.id}
    render layout:"layouts/guide"
  end

  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        format.html { redirect_to @city, notice: 'City was successfully created.' }
        format.json { render action: 'show', status: :created, location: @city }
      else
        format.html { render action: 'new' }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to @city, notice: 'City was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to cities_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:state_id, :name, :description, :latitude, :longitude, :zoom, :slug, :campsites_count, :file, :page, :lead_phto, :lead_license)
    end
end
