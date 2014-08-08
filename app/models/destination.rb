class Destination < ActiveRecord::Base
  belongs_to :state

  # import CSV file
  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      Destination.create! row.to_hash
      #sleep(0.5)
    end
  end
end
