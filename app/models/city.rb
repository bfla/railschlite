class City < ActiveRecord::Base
  belongs_to :state
  has_many :campsites
  validates :name, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true

  # import CSV file
  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      City.create! row.to_hash
      #sleep(0.5)
    end
  end
end
