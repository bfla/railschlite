class Campsite < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude
  validates :name, presence:true, allow_blank:false
  validates :longitude, presence:true, numericality: { less_than: 0 }
  validates :latitude, presence:true, numericality: { greater_than: 0}
  validates :elevation, allow_nil:true, numericality: { only_integer:true }
  validates :showers, :outhouse, :dump, allow_nil:true, inclusion: { in: [true, false] }

  def to_json_v1
    self.to_json
  end

end
