class SearchesController < ApplicationController
  def show
    zoom = params[:zoom] || 10
    distance = params[:distance] || 30
    coordinates = Geocoder.coordinates(params[:keywords])
    @campsites = Campsite.near(coordinates, distance).first(100)
    @campsites = Campsite.name_search(params[:keywords]) if @campsites.blank?

    # Position the map
    @campsites.blank? ? @center = coordinates : @center = Geocoder::Calculations.geographic_center(@campsites)

    # Create geojson for campsites to display in MapBox
    @geojson = Array.new
    @campsites.each { |campsite| @geojson << campsite.geojsonify}
    gon.campsites, gon.geoJson, gon.center, gon.zoom = @campsites, @geojson, @center, zoom
    gon.initTribe = params[:tribe_id] || 0
  end

  private 
    # Never trust parameters from the scary internet, only allow the white list through.
    def campsite_params
      params.require(:keywords).permit(:distance, :zoom, :tribe_id)
    end
end
