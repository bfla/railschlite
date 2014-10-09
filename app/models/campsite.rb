class Campsite < ActiveRecord::Base
  extend CampsiteSearchers
  include CampsiteFormatters
  # Use friendly ids for urls
  extend FriendlyId

  friendly_id :slug_me_up, use: :slugged
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

  has_attached_file :lead_photo, :styles => { :header => "2000x400#", :thumb => ["200x200#", :png] }, :default_url => "/images/:style/missing.png"
  validates_attachment :lead_photo, size: {less_than: 5.megabytes}
  validates_attachment_content_type :lead_photo, :content_type => ['image/jpeg', 'image/png']

  def self.by_name
    order('name ASC')
  end

  def self.featured
    where(featured: true)
  end

  def similar(campsites)
    if self.horse
      campsites.where(horse:true)
    elsif self.backcountry
      campsites.where(backcountry:true)
    elsif self.rv
      campsites.where(rv:true)
    else
      campsites.where(rustic:true)
    end
  end

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

  def self.special_one_time_import(file)
    CSV.foreach(file.path, headers:true) do |row|
      upload = row.to_hash
      c = Campsite.find_by_orig_id(upload["orig_id"])
      puts "GOT CG WITH NAME #{c.name}"
      c.update(slug:upload["slug"], city_name:upload["city_name"]) #if c.present?
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
