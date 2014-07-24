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

ActiveRecord::Schema.define(version: 20140723221158) do

  create_table "campsites", force: true do |t|
    t.string   "name"
    t.string   "state"
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
  end

  add_index "campsites", ["backcountry"], name: "index_campsites_on_backcountry"
  add_index "campsites", ["dump"], name: "index_campsites_on_dump"
  add_index "campsites", ["horse"], name: "index_campsites_on_horse"
  add_index "campsites", ["latitude"], name: "index_campsites_on_latitude"
  add_index "campsites", ["longitude"], name: "index_campsites_on_longitude"
  add_index "campsites", ["rustic"], name: "index_campsites_on_rustic"
  add_index "campsites", ["rv"], name: "index_campsites_on_rv"
  add_index "campsites", ["showers"], name: "index_campsites_on_showers"

end
