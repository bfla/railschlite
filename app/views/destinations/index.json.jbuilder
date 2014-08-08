json.array!(@destinations) do |destination|
  json.extract! destination, :id, :state_id, :name, :description, :latitude, :longitude, :zoom, :radius, :slug, :highlights, :things_to_do, :camping_tips
  json.url destination_url(destination, format: :json)
end
