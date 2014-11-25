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

ActiveRecord::Schema.define(version: 20141124212234) do

  create_table "for_selects", force: true do |t|
    t.string   "code"
    t.string   "value"
    t.string   "text"
    t.string   "grouper"
    t.integer  "option_order"
    t.string   "facility"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "for_selects", ["code"], name: "index_for_selects_on_code"

  create_table "patients", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "number"
    t.string   "facility"
    t.string   "ward"
    t.date     "doa"
    t.date     "dob"
    t.date     "dod"
    t.string   "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "patients", ["facility"], name: "index_patients_on_facility"
  add_index "patients", ["ward"], name: "index_patients_on_ward"

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "authen"
    t.string   "facility"
    t.string   "role"
    t.string   "email"
    t.string   "firstinitial"
    t.string   "middleinitial"
    t.string   "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["facility"], name: "index_users_on_facility"

  create_table "weekly_notes", force: true do |t|
    t.string   "danger_yn"
    t.string   "drugs_last_changed"
    t.string   "drugs_not_why",      limit: 4000
    t.string   "drugs_change_why",   limit: 4000
    t.date     "meeting_date"
    t.integer  "patient_id"
    t.string   "pre_date_yesno"
    t.string   "pre_date_no_why",    limit: 4000
    t.date     "pre_date"
    t.string   "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "weekly_notes", ["patient_id"], name: "index_weekly_notes_on_patient_id"

end
