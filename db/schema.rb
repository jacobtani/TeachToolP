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

ActiveRecord::Schema.define(version: 20151028092647) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "enrolments", force: :cascade do |t|
    t.integer  "person_id",       null: false
    t.datetime "date"
    t.integer  "subject_id",      null: false
    t.datetime "activation_date"
    t.float    "fees"
    t.boolean  "deferred?"
    t.datetime "start_date"
  end

  add_index "enrolments", ["person_id"], name: "index_enrolments_on_person_id", using: :btree
  add_index "enrolments", ["subject_id"], name: "index_enrolments_on_subject_id", using: :btree

  create_table "offers", force: :cascade do |t|
    t.string   "offer_name"
    t.text     "offer_description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "includes_free_trial"
  end

  create_table "ribbons", force: :cascade do |t|
    t.string  "name"
    t.integer "subject_id", null: false
  end

  add_index "ribbons", ["subject_id"], name: "index_ribbons_on_subject_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string "subject_name"
    t.float  "fee"
    t.text   "grades",       default: [], array: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                          null: false
    t.string   "surname",                             null: false
    t.datetime "date_of_birth",                       null: false
    t.string   "role",                                null: false
    t.string   "username",                            null: false
    t.string   "password",                            null: false
    t.string   "phone_number"
    t.text     "mailing_address",                     null: false
    t.text     "postal_address"
    t.integer  "number_of_enrolments"
    t.float    "overdue_fees"
    t.float    "coupon_value"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
