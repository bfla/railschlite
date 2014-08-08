class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.string :abbrev
      t.text :description
      t.float :latitude
      t.float :longitude
      t.string :hashtag
      t.integer :zoom
      t.integer :campsites_count, default: 0
      t.string :slug

      t.timestamps
    end
    add_index :states, :abbrev
    add_column :campsites, :state_id, :integer
  end
end
