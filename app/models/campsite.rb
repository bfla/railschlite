class Campsite < ActiveRecord::Base
  extend CampsiteSearchers
  include CampsiteFormatters
  # include CampsiteDataHandlers

  #extend FriendlyId
  #friendly_id :slug_me_up, use: :slugged

  reverse_geocoded_by :latitude, :longitude, address: :location
  belongs_to :state, counter_cache: :campsites_count
  belongs_to :city, counter_cache: :campsites_count
  validates :name, presence:true, allow_blank:false
  validates :state_abbrev, presence:true, allow_blank:false
  validates :phone, allow_nil:true, numericality: { only_integer: true }
  validates :longitude, presence:true, numericality: { less_than: 0 }
  validates :latitude, presence:true, numericality: { greater_than: 0}
  validates :elevation, allow_nil:true, numericality: { only_integer:true }
  validates :showers, :outhouse, :dump, :rustic, :rv, :backcountry, :horse,
            allow_nil:true, inclusion: { in: [true, false] }
  #before_save :analyze_toilets

  def add_city_and_address
    geo_results = Geocoder.search("#{self.latitude}, #{self.longitude}")
    if geo = geo_results.first
      self.address = geo.address
      self.city_name = geo.city
      self.save
    end
  end

  #def analyze_toilets
    #if self.no_toilets.nil?
      #self.no_toilets = true if self.backcountry && !self.outhouse
    #end
    #if !self.no_toilets && !self.likely_toilets
      #self.likely_toilets = true if self.outhouse || self.showers || self.plumbing
    #end
  #end

  # import CSV file
  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      Campsite.create! row.to_hash
      #sleep(0.5)
    end
  end

  # Format URLs like this
  def slug_me_up
    if name
      "#{name} in #{city_name} #{state_abbrev} camping"
    else
      ""
    end
  end
end
