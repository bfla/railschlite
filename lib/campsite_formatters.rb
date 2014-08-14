module CampsiteFormatters

  def city_name # I should probably just save this to campsite bc it is static
    city.name if city
  end

  def city_campsites_count # I should probably just save this to campsite bc it is static
    city.campsites_count if city
  end

  def state_name # I should probably just save this to campsite bc it is static
    state.name if state
  end
  
  def to_json_v1
    electric_bool =  if self.electric_sites && self.electric_sites > 0
      true 
    elsif self.electric_sites && self.electric_sites == 0
      false
    else
      nil
    end
    warning = if self.boatin
      "Might only accessible by boat."
    else
      nil
    end

    json = {
      id: self.id,
      name: self.name,
      state: self.state_abbrev,
      owner: self.owner,
      latitude: self.latitude,
      longitude: self.longitude,
      elevation: self.elevation,
      phone: self.phone,
      url: self.url,
      showers: self.showers,
      dump: self.dump,
      electricity:self.electricity,
      likely_toilets: self.likely_toilets,
      no_toilets: self.no_toilets,
      water: self.water,
      electric_sites: electric_bool,
      rustic: self.rustic,
      rv: self.rv,
      backcountry: self.backcountry,
      horse: self.horse,
      warning: warning }
  end

  def to_geojson
    geojson = {
      type: 'Feature',
      geometry: {
        type: 'Point',
        coordinates: [self.longitude, self.latitude]
      },
      properties: {
        title: self.name,
        campsiteId:self.id,
        rustic:self.rustic,
        rv:self.rv,
        backcountry:self.backcountry,
        # Extra data for iOS search:
        #reservable: self.reservable,
        #walkins: self.walkins,
        #avg_rating: self.avg_rating,
        #ranking: self.rank,
        #tribes_dict: self.tribes.each {|tribe| self.tribes << tribe.to_json },
        #reviews_dict: self.reviews.each { |review| self.reviews << review.to_json },
        :'marker-color' => "\#09b",
        :'marker-symbol' => 'campsite',
        :'marker-size' => 'large'
      }
    }
  end
end