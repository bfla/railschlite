class ChangeUrlToTextType < ActiveRecord::Migration
  def up
    change_column :campsites, :url, :text
  end
  def down
    change_column :campsites, :url, :string
  end
end
