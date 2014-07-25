class Campsite < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude
  validates :name, presence:true, allow_blank:false
  validates :state, presence:true, allow_blank:false
  validates :phone, allow_nil:true, numericality: { only_integer: true }
  validates :longitude, presence:true, numericality: { less_than: 0 }
  validates :latitude, presence:true, numericality: { greater_than: 0}
  validates :elevation, allow_nil:true, numericality: { only_integer:true }
  validates :showers, :outhouse, :dump, :rustic, :rv, :backcountry, :horse,
            allow_nil:true, inclusion: { in: [true, false] }
  before_save :analyze_toilets

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
      state: self.state,
      owner: self.owner,
      latitude: self.latitude,
      longitude: self.longitude,
      elevation: self.elevation,
      phone: self.phone,
      url: self.url,
      showers: self.showers,
      dump: self.dump,
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

  def analyze_toilets
    self.no_toilets = true if self.backcountry && !self.outhouse
    if !self.no_toilets
      self.likely_toilets = true if self.outhouse || self.showers || self.plumbing
    end
  end

  # import CSV file
  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      Campsite.create! row.to_hash
      #sleep(0.5)
    end
  end
end
