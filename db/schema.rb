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

ActiveRecord::Schema.define(version: 20151113075943) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "enclosure_types", force: :cascade do |t|
    t.integer "type"
  end

  create_table "enclosures", force: :cascade do |t|
    t.string   "name"
    t.integer  "barcode"
    t.boolean  "returnable?"
    t.string   "status"
    t.datetime "due_date"
  end

  create_table "enrolments", force: :cascade do |t|
    t.datetime "date"
    t.integer  "subject_id",      null: false
    t.datetime "activation_date"
    t.float    "fees"
    t.boolean  "deferred?"
    t.datetime "start_date"
    t.integer  "user_id",         null: false
    t.integer  "grade",           null: false
  end

  add_index "enrolments", ["subject_id"], name: "index_enrolments_on_subject_id", using: :btree
  add_index "enrolments", ["user_id"], name: "index_enrolments_on_user_id", using: :btree

  create_table "offers", force: :cascade do |t|
    t.string   "offer_name"
    t.text     "offer_description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "includes_free_trial"
  end

  create_table "pack_records", force: :cascade do |t|
    t.datetime "record_date"
    t.string   "comment"
    t.string   "status"
    t.datetime "due_date"
    t.integer  "pack_id",                   null: false
    t.integer  "user_id",                   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "score",       default: 0
    t.float    "reward",      default: 0.0
    t.datetime "start_date"
  end

  add_index "pack_records", ["pack_id"], name: "index_pack_records_on_pack_id", using: :btree
  add_index "pack_records", ["user_id"], name: "index_pack_records_on_user_id", using: :btree

  create_table "packs", force: :cascade do |t|
    t.string  "name"
    t.text    "description"
    t.text    "action_required"
    t.integer "subject_id",      null: false
    t.boolean "in_stock?"
  end

  add_index "packs", ["subject_id"], name: "index_packs_on_subject_id", using: :btree

  create_table "packtypes", force: :cascade do |t|
    t.integer "type"
  end

  create_table "ribbons", force: :cascade do |t|
    t.string  "name"
    t.integer "subject_id", null: false
  end

  add_index "ribbons", ["subject_id"], name: "index_ribbons_on_subject_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string  "subject_name"
    t.float   "fee"
    t.integer "lowest_grade_taught"
    t.integer "highest_grade_taught"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                           null: false
    t.string   "surname",                              null: false
    t.datetime "date_of_birth"
    t.string   "role",                                 null: false
    t.string   "username"
    t.string   "password"
    t.string   "phone_number"
    t.text     "mailing_address"
    t.text     "postal_address",                       null: false
    t.float    "overdue_fees",           default: 0.0
    t.float    "coupon_value",           default: 0.0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "email",                  default: "",  null: false
    t.string   "encrypted_password",     default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "parent_id"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.string   "contact_mobile"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
