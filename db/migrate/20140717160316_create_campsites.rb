class CreateCampsites < ActiveRecord::Migration
  def change
    create_table :campsites do |t|
      t.string :name
      t.string :state
      t.float :latitude
      t.float :longitude
      t.integer :elevation
      t.integer :phone
      t.integer :total_sites
      t.integer :electric_sites
      t.boolean :outhouse
      t.boolean :showers
      t.boolean :dump

      t.timestamps
    end

    add_index :campsites, :latitude
    add_index :campsites, :longitude
  end
end
