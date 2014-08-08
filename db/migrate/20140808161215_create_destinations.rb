class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.integer :state_id
      t.string :name
      t.text :description
      t.float :latitude
      t.float :longitude
      t.integer :zoom
      t.integer :radius
      t.string :slug
      t.text :highlights
      t.text :things_to_do
      t.text :camping_tips

      t.timestamps
    end
    add_index :destinations, :slug
    add_index :destinations, :state_id
  end
end
