class State < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_me_up, use: :slugged

  has_many :cities
  has_many :destinations
  has_many :campsites
  has_many :top_campsites, :class_name => 'Campsite', :limit => 10
  has_many :top_destinations, :class_name => 'Destination', :limit => 10
  has_many :top_cities, :class_name => 'City', :limit => 10
  has_attached_file :lead_photo, :styles => { :header => "2000x400>", :thumb => ["200x200#", :png] }, :default_url => "/images/:style/missing.png"
  validates_attachment :lead_photo, size: {less_than: 5.megabytes}
  validates_attachment_content_type :lead_photo, :content_type => ['image/jpeg', 'image/png']
  validates :abbrev, presence: true


  def cities_count #Create a column to cache this count...
    cities.size
  end

  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      upload = row.to_hash
      State.create(name:upload["name"], abbrev:upload["abbrev"])
      #City.create! row.to_hash
      #sleep(0.5)
    end
  end

  def slug_me_up
    "#{name} camping"
  end
end
