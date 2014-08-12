# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140812151547) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "approved",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["approved"], name: "index_admins_on_approved"
  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "campsites", force: true do |t|
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
    t.text     "url",            limit: 255
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
    t.boolean  "likely_toilets",             default: false
    t.boolean  "no_toilets",                 default: false
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
    t.string   "slug"
  end

  add_index "campsites", ["backcountry"], name: "index_campsites_on_backcountry"
  add_index "campsites", ["city_id"], name: "index_campsites_on_city_id"
  add_index "campsites", ["dump"], name: "index_campsites_on_dump"
  add_index "campsites", ["horse"], name: "index_campsites_on_horse"
  add_index "campsites", ["latitude"], name: "index_campsites_on_latitude"
  add_index "campsites", ["longitude"], name: "index_campsites_on_longitude"
  add_index "campsites", ["rustic"], name: "index_campsites_on_rustic"
  add_index "campsites", ["rv"], name: "index_campsites_on_rv"
  add_index "campsites", ["showers"], name: "index_campsites_on_showers"
  add_index "campsites", ["slug"], name: "index_campsites_on_slug"
  add_index "campsites", ["state_id"], name: "index_campsites_on_state_id"

  create_table "cities", force: true do |t|
    t.integer  "state_id"
    t.string   "name"
    t.string   "state_abbrev"
    t.string   "state_hashtag"
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "zoom"
    t.string   "slug"
    t.integer  "campsites_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "orig_id"
    t.integer  "zip"
  end

  add_index "cities", ["latitude"], name: "index_cities_on_latitude"
  add_index "cities", ["longitude"], name: "index_cities_on_longitude"
  add_index "cities", ["slug"], name: "index_cities_on_slug"
  add_index "cities", ["state_id"], name: "index_cities_on_state_id"

  create_table "destinations", force: true do |t|
    t.integer  "state_id"
    t.string   "name"
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "zoom"
    t.integer  "radius"
    t.string   "slug"
    t.text     "highlights"
    t.text     "things_to_do"
    t.text     "camping_tips"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "orig_id"
  end

  add_index "destinations", ["slug"], name: "index_destinations_on_slug"
  add_index "destinations", ["state_id"], name: "index_destinations_on_state_id"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "states", force: true do |t|
    t.string   "name"
    t.string   "abbrev"
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "hashtag"
    t.integer  "zoom"
    t.integer  "campsites_count", default: 0
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["abbrev"], name: "index_states_on_abbrev"

end
