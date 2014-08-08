class State < ActiveRecord::Base
  validates :abbrev, presence: true
end
