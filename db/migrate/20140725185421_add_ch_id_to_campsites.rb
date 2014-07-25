class AddChIdToCampsites < ActiveRecord::Migration
  def change
    add_column :campsites, :ch_id, :integer
  end
end
