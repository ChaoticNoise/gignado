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

ActiveRecord::Schema.define(version: 20170815014805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "type"
    t.string "title"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "location"
    t.text "details"
    t.jsonb "data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.datetime "confirmation_deadline"
    t.integer "payment_status", default: 0
    t.integer "booker_id"
    t.integer "day_pic_id"
    t.integer "gig_pic_id"
    t.integer "bus_pic_id"
    t.integer "rehearsal_pic_id"
    t.datetime "synced_at"
    t.string "gigo_key"
    t.datetime "call_time"
    t.index ["data"], name: "index_events_on_data", using: :gin
  end

  create_table "members", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "image_url"
    t.datetime "activated_at"
    t.integer "status", default: 0
    t.boolean "has_patch", default: false
    t.boolean "section_lead", default: false
    t.integer "section", default: 0
    t.boolean "has_bus_insurance", default: false
    t.string "gigo_key"
    t.jsonb "data", default: {}, null: false
    t.index ["data"], name: "index_members_on_data", using: :gin
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
  end

  create_table "promotions", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "time_display"
    t.string "location_display"
    t.string "location_url"
    t.text "details"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
