class Campsite < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude
  validates :name, presence:true, allow_blank:false
  validates :longitude, presence:true, numericality: { less_than: 0 }
  validates :latitude, presence:true, numericality: { greater_than: 0}
  validates :elevation, allow_nil:true, numericality: { only_integer:true }
  validates :showers, :outhouse, :dump, allow_nil:true, inclusion: { in: [true, false] }

  def to_json_v1
    json = {
      id: self.id,
      name: self.name,
      state: self.state,
      latitude: self.latitude,
      longitude: self.longitude,
      elevation: self.elevation,
      showers: self.showers,
      dump: self.dump,
      outhouse: self.outhouse, }
  end
end
