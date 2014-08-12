class Destination < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_me_up, use: :slugged
  reverse_geocoded_by :latitude, :longitude

  belongs_to :state

  # import CSV file
  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      Destination.create! row.to_hash
      #sleep(0.5)
    end
  end

  # use friendly ids for urls
  def slug_me_up
    "#{name} #{state.abbreviation} camping"
  end
end
