class AddPhotoAttachmentsToPlaces < ActiveRecord::Migration
  def self.up
    add_attachment :states, :lead_photo
    add_attachment :campsites, :lead_photo
    add_attachment :cities, :lead_photo
    add_attachment :destinations, :lead_photo
    add_column :states, :lead_license, :string
    add_column :campsites, :lead_license, :string
    add_column :cities, :lead_license, :string
    add_column :destinations, :lead_license, :string
  end
  def self.down
    remove_attachment :states, :lead_photo
    remove_attachment :campsites, :lead_photo
    remove_attachment :cities, :lead_photo
    remove_attachment :destinations, :lead_photo
    remove_column :states, :lead_license, :string
    remove_column :campsites, :lead_license, :string
    remove_column :cities, :lead_license, :string
    remove_column :destinations, :lead_license, :string
  end
end
