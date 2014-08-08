class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :state_id
      t.string :name
      t.string :state_abbrev
      t.string :state_hashtag
      t.text :description
      t.float :latitude
      t.float :longitude
      t.integer :zoom
      t.string :slug
      t.integer :campsites_count, default: 0

      t.timestamps
    end
    add_index :cities, :slug
    add_index :cities, :state_id
    add_index :cities, :longitude
    add_index :cities, :latitude
    add_column :campsites, :city_id, :integer
    add_index :campsites, :city_id
    add_index :campsites, :state_id
  end
end
