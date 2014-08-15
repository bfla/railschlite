class StatesController < ApplicationController
  before_action :set_state, only: [:edit, :update, :destroy]
  before_action :verify_admin, except: [:show, :index, :browse_destinations, :browse_cities, :browse_campgrounds]

  # GET /states
  # GET /states.json
  def index
    @states = State.all
  end

  def browse_destinations
    @state = State.includes(:destinations).friendly.find(params[:id])
  end

  def browse_cities
    @state = State.includes(:cities).friendly.find(params[:id])
  end

  def browse_campgrounds
    @state = State.friendly.find(params[:id])
    @campsites = Campsite.where(state_id:@state.id).by_name.page(params[:page]).per(16)
  end

  # GET /states/1
  # GET /states/1.json
  def show
    @state = State.includes(:top_campsites, :top_cities, :top_destinations).friendly.find(params[:id])
    render layout: "layouts/guide"
  end

  # GET /states/new
  def new
    @state = State.new
  end

  # GET /states/1/edit
  def edit
  end

  # POST /states
  # POST /states.json
  def create
    @state = State.new(state_params)

    respond_to do |format|
      if @state.save
        format.html { redirect_to @state, notice: 'State was successfully created.' }
        format.json { render action: 'show', status: :created, location: @state }
      else
        format.html { render action: 'new' }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /states/1
  # PATCH/PUT /states/1.json
  def update
    respond_to do |format|
      if @state.update(state_params)
        format.html { redirect_to @state, notice: 'State was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /states/1
  # DELETE /states/1.json
  def destroy
    @state.destroy
    respond_to do |format|
      format.html { redirect_to states_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def state_params
      params.require(:state).permit(:name, :abbrev, :description, :latitude, :longitude, :hashtag, :zoom, :slug, :lead_photo)
    end
end
