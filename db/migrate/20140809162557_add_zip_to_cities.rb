class AddZipToCities < ActiveRecord::Migration
  def change
    add_column :cities, :zip, :integer
  end
end
