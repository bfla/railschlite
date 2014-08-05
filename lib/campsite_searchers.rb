module CampsiteSearchers

  def name_search(keywords)
    if keywords
      where('LOWER(name) LIKE ?', "%#{keywords.downcase}%") || Campsite.none
    else
      Campsite.none
    end
  end

  def map_search(keywords, zoom, distance)
    zoom = zoom || 10
    distance = distance || 30
    coordinates = Geocoder.coordinates(keywords)
    campsites = Campsite.near(coordinates, distance).first(50)
    campsites ||= Campsite.name_search(params[:keywords])
    return campsites, zoom, distance, coordinates
  end

end