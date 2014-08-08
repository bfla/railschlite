json.array!(@cities) do |city|
  json.extract! city, :id, :state_id, :name, :description, :latitude, :longitude, :zoom, :slug, :campsites_count
  json.url city_url(city, format: :json)
end
