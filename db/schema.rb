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

ActiveRecord::Schema.define(version: 20160326071454) do

  create_table "twilio_messages", force: :cascade do |t|
    t.string   "to_country"
    t.string   "to_state"
    t.string   "sms_message_sid"
    t.integer  "num_media"
    t.string   "to_city"
    t.integer  "from_zip"
    t.string   "sms_sid"
    t.string   "from_state"
    t.string   "sms_status"
    t.string   "from_city"
    t.string   "body"
    t.string   "from_country"
    t.string   "to"
    t.string   "messaging_service_sid"
    t.integer  "to_zip"
    t.integer  "num_segments"
    t.string   "message_sid"
    t.string   "account_sid"
    t.string   "from"
    t.string   "api_version"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "message_category"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
