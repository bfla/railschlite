json.array!(@campsites) do |campsite|
  json.extract! campsite, :id, :name, :state, :latitude, :longitude, :elevation, :phone, :total_sites, :electric_sites, :outhouse, :showers, :dump
  json.url campsite_url(campsite, format: :json)
end
