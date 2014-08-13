module CitiesHelper
  def city_header_url(city)
    asset_path "/images/backgrounds/camping-header.jpg"
  end
  def search_city_map(city)
    distance = city.zoom || 30
    searches_path(keywords:"#{city.latitude}, #{city.longitude}", distance:distance)
  end
  def city_rustic_campsites(city)
    city.campsites.where(rustic:true)
  end
  def city_rv_campsites(city)
    city.campsites.where(rv:true)
  end
  def city_backcountry_campsites(city)
    city.campsites.where(backcountry:true)
  end
end
