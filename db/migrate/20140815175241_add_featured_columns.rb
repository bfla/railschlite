class AddFeaturedColumns < ActiveRecord::Migration
  def change
    add_column :campsites, :featured, :boolean, default:false
    add_column :cities, :featured, :boolean, default:false
    add_column :destinations, :featured, :boolean, default:false
    add_column :states, :featured, :boolean, default:false
    add_index :states, :featured
    add_index :campsites, :featured
    add_index :cities, :featured
    add_index :destinations, :featured
  end
end
