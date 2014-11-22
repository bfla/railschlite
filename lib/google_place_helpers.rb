
module GooglePlaceHelpers

  class GooglePlace
    API_KEY = "AIzaSyB9mHzeQJxtkMkn_UkKAOs00Hkg2Y9qKds"
    ACCEPTABLE_IMG_TYPES = ["park", "campground", "natural_feature", "rv_park", "locality", "point_of_interest"]

    def initialize(lat, lng, *args)
      @lat = lat
      @lng = lng
      @src = nil
      @res = nil
      @license = nil
      @places = nil
      get_photo()
    end

    # run a Google Places search
    def get_places
      endpoint = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@lat},#{@lng}&radius=8000&sensor=false&key=#{API_KEY}"
      gplace_response = Net::HTTP.get_response(URI.parse(endpoint))
      @places = JSON.parse(gplace_response.body)
    end # end of fetch_google_photos()

    # Gets nearby photos given a latitude and longitude
    def get_photo
      get_places # Get nearby Google places

      @places["results"].each do |place| # Process each result
        if place["photos"] and place["types"] #Look for a usable photo
          place["types"].each do |type|
            if ACCEPTABLE_IMG_TYPES.include? type # Remove types that don't match
              photo = place["photos"].first
              @license = photo["html_attributions"] if photo["html_attributions"]
              photo_ref = photo["photo_reference"]
              @src = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&maxheight=400&photoreference=#{photo_ref}&sensor=true&key=#{API_KEY}"
              response = Net::HTTP.get_response(URI.parse(@src))
              @res = response.body
              break # since we now have a photo, break the loop
            end
          end
        end #of photo processing
      end
    end # of get_google_photos()

    attr_reader :img
    attr_reader :src
    attr_reader :license

  end # of GooglePhoto class

end # of GooglePlaceHelpers module