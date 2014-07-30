class RenameStateToStateNameInCampsites < ActiveRecord::Migration
  def change
    rename_column :campsites, :state, :state_abbrev
    add_column :campsites, :city_name, :string
    add_column :campsites, :address, :string
    add_column :campsites, :sewer_hookup, :boolean
    add_column :campsites, :fifty_amp, :boolean
    add_column :campsites, :thirty_amp, :boolean
    add_column :campsites, :twenty_amp, :boolean
    add_column :campsites, :pull_thrus, :boolean
    add_column :campsites, :wifi, :boolean
    add_column :campsites, :laundry, :boolean
    add_column :campsites, :beach, :boolean
    add_column :campsites, :on_lake, :boolean
    add_column :campsites, :on_river, :boolean
  end
end
