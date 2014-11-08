json.array!(@campsites) do |campsite|
  json.extract! campsite,
  	:id, :name, :state_abbrev, :slug,
    :latitude, :longitude, :elevation,
    :backcountry, :rustic, :rv, :horse
end