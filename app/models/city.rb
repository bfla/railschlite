class City < ActiveRecord::Base
  extend FriendlyId # use friendly ids for urls
  friendly_id :slug_me_up, use: :slugged
  reverse_geocoded_by :latitude, :longitude

  belongs_to :state
  has_many :campsites
  validates :name, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true

  has_attached_file :lead_photo, :styles => { :header => "2000x400#", :thumb => ["200x200#", :png] }, :default_url => "/images/:style/missing.png"
  validates_attachment :lead_photo, size: {less_than: 5.megabytes}
  validates_attachment_content_type :lead_photo, :content_type => ['image/jpeg', 'image/png']

  
  def self.featured
    where(featured: true)
  end

  def state_name
    state.present? ? state.name : nil
  end

  # import CSV file
  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      upload = row.to_hash
      City.create(name:upload["name"], state_abbrev:upload["state_abbrev"], description:upload["description"],
                  longitude:upload["longitude"], latitude:upload["latitude"], zoom:upload["zoom"],
                  slug:upload["slug"], campsites_count:upload["campsites_count"])
      #City.create! row.to_hash
      #sleep(0.5)
    end
  end

  def slug_me_up
    "#{name} #{state.abbrev} camping"
  end
end
