class SearchesController < ApplicationController
  def show
    @zoom = params[:zoom] || 10
    @distance = params[:distance] || 30
    @keywords = params[:keywords]
    
    if params[:lat] && params[:lng]
      coordinates = [ params[:lat], params[:lng] ]
      @campsites = Campsite.near(coordinates, @distance).first(200)
    else
      @keywords ||= "Glen Arbor MI"
      coordinates = Geocoder.coordinates(@keywords)
      @campsites = Campsite.near(coordinates, @distance).first(200)
      @campsites = Campsite.name_search(@keywords) if @campsites.blank?
    end

    # Position the map
    @campsites.blank? ? @center = coordinates : @center = Geocoder::Calculations.geographic_center(@campsites)
  end

  private 
    def campsite_params
      params.permit(:keywords, :distance, :zoom, :tribe_id, :lat, :lng)
    end
end
