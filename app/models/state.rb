class State < ActiveRecord::Base
  validates :abbrev, presence: true
  has_many :cities
  has_many :destinations
  has_many :campsites
end
