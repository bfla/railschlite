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

ActiveRecord::Schema.define(version: 20140717160316) do

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
  end

  add_index "campsites", ["latitude"], name: "index_campsites_on_latitude"
  add_index "campsites", ["longitude"], name: "index_campsites_on_longitude"

end
