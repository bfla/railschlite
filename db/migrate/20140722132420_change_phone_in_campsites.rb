class ChangePhoneInCampsites < ActiveRecord::Migration
  def up
    change_column :campsites, :phone, :bigint
  end
  def down
    change_column :campsites, :phone, :integer
  end
end
