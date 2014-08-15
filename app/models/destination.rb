class Destination < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_me_up, use: :slugged
  reverse_geocoded_by :latitude, :longitude
  belongs_to :state

  has_attached_file :lead_photo, :styles => { :header => "2000x400#", :thumb => ["200x200#", :png] }, :default_url => "/images/:style/missing.png"
  validates_attachment :lead_photo, size: {less_than: 5.megabytes}
  validates_attachment_content_type :lead_photo, :content_type => ['image/jpeg', 'image/png']


  def self.featured
    where(featured: true)
  end
  def state_abbrev
    state.abbrev if state.present?
  end
  def state_name
    state.name if state.present?
  end
  def state_hashtag
    state.hashtag if state.present?
  end
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
