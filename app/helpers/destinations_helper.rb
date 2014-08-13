module DestinationsHelper

  def destination_header_url(destination)
    asset_path "/images/backgrounds/camping-header.jpg"
  end
  def search_destination_map(destination)
    distance = destination.radius || 40
    searches_path(keywords:"#{destination.latitude}, #{destination.longitude}", distance:distance)
  end
  def rustic_campsites(campsites)
    campsites.where(rustic: true)
  end
  def rv_campsites(campsites)
    campsites.where(rv: true)
  end
  def backcountry_campsites(campsites)
    campsites.where(backcountry: true)
  end
end
