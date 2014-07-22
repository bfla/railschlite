class Api::V1::SearchesController < ApplicationController
  
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


  def campsite_params
    params.require(:keywords).permit(:distance)
  end
end