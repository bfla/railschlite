class AddInitialFieldsToCampsites < ActiveRecord::Migration
  def change
    add_column :campsites, :num, :integer
    add_column :campsites, :uuid, :string
    add_column :campsites, :url, :string
    add_column :campsites, :owner, :string
    add_column :campsites, :rv_sites, :integer
    add_column :campsites, :plumbing, :boolean
    add_column :campsites, :water, :boolean
    add_column :campsites, :tent_allowed, :boolean
    add_column :campsites, :rv_allowed, :boolean
    add_column :campsites, :walkin, :boolean
    add_column :campsites, :hikein, :boolean
    add_column :campsites, :boatin, :boolean
    add_column :campsites, :rustic, :boolean
    add_column :campsites, :rv, :boolean
    add_column :campsites, :backcountry, :boolean
    add_column :campsites, :horse, :boolean

    add_index :campsites, :rustic
    add_index :campsites, :rv
    add_index :campsites, :backcountry
    add_index :campsites, :horse
    add_index :campsites, :showers
    add_index :campsites, :dump
  end
end
