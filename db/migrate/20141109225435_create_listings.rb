class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :name
      t.string   "name"
	    t.string   "state_abbrev"
	    t.float    "latitude"
	    t.float    "longitude"
	    t.integer  "elevation"
	    t.integer  "phone"
	    t.integer  "total_sites"
	    t.integer  "electric_sites"
	    t.boolean  "outhouse"
	    t.boolean  "showers"
	    t.boolean  "dump"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	    t.integer  "num"
	    t.string   "uuid"
	    t.text     "url", limit: 255
	    t.string   "owner"
	    t.integer  "rv_sites"
	    t.boolean  "plumbing"
	    t.boolean  "water"
	    t.boolean  "tent_allowed"
	    t.boolean  "rv_allowed"
	    t.boolean  "walkin"
	    t.boolean  "hikein"
	    t.boolean  "boatin"
	    t.boolean  "rustic"
	    t.boolean  "rv"
	    t.boolean  "backcountry"
	    t.boolean  "horse"
	    t.boolean  "likely_toilets", default: false
	    t.boolean  "no_toilets", default: false
	    t.integer  "orig_id"
	    t.boolean  "electricity"
	    t.string   "city_name"
	    t.string   "address"
	    t.boolean  "sewer_hookup"
	    t.boolean  "fifty_amp"
	    t.boolean  "thirty_amp"
	    t.boolean  "twenty_amp"
	    t.boolean  "pull_thrus"
	    t.boolean  "wifi"
	    t.boolean  "laundry"
	    t.boolean  "beach"
	    t.boolean  "on_lake"
	    t.boolean  "on_river"
	    t.integer  "state_id"
	    t.integer  "city_id"
      	t.timestamps
    end
  end
end
