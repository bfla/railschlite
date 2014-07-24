class Api::V1::CampsitesController < ApplicationController
  before_action :set_campsite_or_404
  before_action :verify_api_key

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

    def verify_api_key
      unless params[:api_key] == "1af20713-4a94-4c86-b1f4-219fb22e7b1a" #v1 API Key
        render json: {error: "Unauthorized API key"}.to_json, status: 401
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campsite_params
      params.require(:campsite).permit(:id, :api_key)
    end
end