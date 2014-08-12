class State < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_me_up, use: :slugged

  validates :abbrev, presence: true
  has_many :cities
  has_many :destinations
  has_many :campsites

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
