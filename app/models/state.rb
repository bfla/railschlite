class State < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_me_up, use: :slugged

  validates :abbrev, presence: true
  has_many :cities
  has_many :destinations
  has_many :campsites
  has_many :top_campsites, :class_name => 'Campsite', :limit => 10
  has_many :top_destinations, :class_name => 'Destination', :limit => 10
  has_many :top_cities, :class_name => 'City', :limit => 10

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
