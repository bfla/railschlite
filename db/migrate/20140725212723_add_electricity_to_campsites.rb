class AddElectricityToCampsites < ActiveRecord::Migration
  def change
    add_column :campsites, :electricity, :boolean
  end
end
