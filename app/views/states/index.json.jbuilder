json.array!(@states) do |state|
  json.extract! state, :id, :name, :abbrev, :description, :latitude, :longitude, :hashtag, :zoom, :slug
  json.url state_url(state, format: :json)
end
