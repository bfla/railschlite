class City < ActiveRecord::Base
  extend FriendlyId # use friendly ids for urls
  friendly_id :slug_me_up, use: :slugged
  reverse_geocoded_by :latitude, :longitude

  belongs_to :state
  has_many :campsites
  validates :name, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true

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
    "#{name} #{state.abbreviation} camping"
  end
end
