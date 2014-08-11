class AddOrigIdsToExportsFromOrigCh < ActiveRecord::Migration
  def change
    add_column :campsites, :slug, :string
    add_index :campsites, :slug
    add_column :cities, :orig_id, :integer
    add_column :destinations, :orig_id, :integer
    rename_column :campsites, :ch_id, :orig_id
  end
end
