class CampsitesController < ApplicationController
  # before_action :set_campsite, only: [:edit, :update, :destroy]
  # before_action :verify_admin, except: [:show, :index, :claim]

  def show
  end

  def new
    @listing = {
      name: 'Rainbow Unicorn Campground',
      one_liner: 'Unicorns are real',
      latitude: 44.8961,
      longitude: -85.9983
    }
  end

  def create
  end 

  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def state_params
      params.require(:state).permit(:name, :abbrev, :description, :latitude, :longitude, :hashtag, :zoom, :slug, :lead_photo, :lead_license)
    end
end
