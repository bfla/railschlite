class Api::V1::CampsitesController < ApplicationController
  before_action :set_campsite_or_404

  # GET /api/v1/campsites/:id
  # Expected output is...
  #  ADD IT HERE
  def show
    render json: @campsite.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campsite_or_404
      begin
        @campsite = Campsite.find(params[:id])
      rescue
        render json: {error: "campsite not found"}.to_json, status: 404
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campsite_params
      params.require(:campsite).permit(:name, :state, :latitude, :longitude, :elevation, :phone, :total_sites, :electric_sites, :outhouse, :showers, :dump)
    end
end