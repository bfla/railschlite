class Api::V1::SearchesController < ApplicationController
  before_action :verify_api_key
  
  # GET /api/v1/searches?keywords=foo&distance=bar
  # Expected output is...
  # ADD IT HERE
  def show
    distance = params[:distance] || 30
    #coordinates = Geocoder.coordinates(params[:keywords])
    #@campsites = Campsite.near(coordinates, distance)
    @campsites = Campsite.near(params[:keywords], distance, order: :name).first(100)

    if @campsites.any?
      @sjson = Array.new
      @campsites.each { |c| @sjson << c.to_json_v1 }
      render json: @sjson # respond with JSON object
    else
      render json: {}
    end

  end

  private
    def verify_api_key
      unless params[:api_key] == "1af20713-4a94-4c86-b1f4-219fb22e7b1a" #v1 API Key
        render json: {error: "Unauthorized key"}.to_json, status: 401
      end
    end

    def campsite_params
      params.require(:keywords).permit(:distance, :api_key)
    end
end