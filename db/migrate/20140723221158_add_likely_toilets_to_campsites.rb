class AddLikelyToiletsToCampsites < ActiveRecord::Migration
  def change
    add_column :campsites, :likely_toilets, :boolean, default: false
    add_column :campsites, :no_toilets, :boolean, default: false
  end
end
