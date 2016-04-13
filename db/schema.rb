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

ActiveRecord::Schema.define(version: 20160411200142) do

  create_table "rankings", force: :cascade do |t|
    t.string   "search_date"
    t.string   "search_site"
    t.string   "search_keyword"
    t.string   "search_market"
    t.string   "search_location"
    t.string   "search_device"
    t.integer  "google"
    t.integer  "google_base_rank"
    t.integer  "yahoo"
    t.integer  "bing"
    t.string   "google_url"
    t.string   "yahoo_url"
    t.string   "bing_url"
    t.decimal  "advertiser_competition"
    t.integer  "global_monthly_searches"
    t.integer  "regional_monthly_searches"
    t.decimal  "cdc"
    t.string   "tags"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

end
