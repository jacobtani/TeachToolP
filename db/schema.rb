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

ActiveRecord::Schema.define(version: 20160319093911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "enclosures", force: :cascade do |t|
    t.string   "name"
    t.integer  "barcode"
    t.boolean  "returnable?"
    t.string   "status"
    t.datetime "due_date"
    t.integer  "enclosure_type", default: 0
    t.integer  "pack_id",                    null: false
  end

  add_index "enclosures", ["pack_id"], name: "index_enclosures_on_pack_id", using: :btree

  create_table "enrolments", force: :cascade do |t|
    t.datetime "date"
    t.integer  "subject_id",                    null: false
    t.datetime "activation_date"
    t.boolean  "deferred?"
    t.datetime "start_date"
    t.integer  "user_id",                       null: false
    t.integer  "grade",                         null: false
    t.integer  "offer_id"
    t.float    "fees",            default: 0.0
    t.integer  "ability_level",   default: 0
  end

  add_index "enrolments", ["offer_id"], name: "index_enrolments_on_offer_id", using: :btree
  add_index "enrolments", ["subject_id"], name: "index_enrolments_on_subject_id", using: :btree
  add_index "enrolments", ["user_id"], name: "index_enrolments_on_user_id", using: :btree

  create_table "fees", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.float    "amount"
    t.integer  "fee_type",   default: 0
    t.integer  "subject_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "fees", ["subject_id"], name: "index_fees_on_subject_id", using: :btree

  create_table "offers", force: :cascade do |t|
    t.string   "offer_name"
    t.text     "offer_description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "number_of_subjects",   default: 0
    t.float    "discount_monthly"
    t.integer  "discount_enrolment"
    t.integer  "percentage_monthly"
    t.integer  "percentage_enrolment"
    t.integer  "subject_id",                       null: false
  end

  add_index "offers", ["subject_id"], name: "index_offers_on_subject_id", using: :btree

  create_table "pack_records", force: :cascade do |t|
    t.datetime "record_date"
    t.string   "comment"
    t.datetime "due_date"
    t.integer  "pack_id",                      null: false
    t.integer  "user_id",                      null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "score",          default: 0
    t.float    "reward",         default: 0.0
    t.datetime "start_date"
    t.integer  "status",         default: 0
    t.integer  "posting_number", default: 0
    t.hstore   "comments"
    t.integer  "accuracy",       default: 0
    t.integer  "completion",     default: 0
    t.integer  "quality",        default: 0
    t.integer  "presentation",   default: 0
    t.integer  "consistency",    default: 0
  end

  add_index "pack_records", ["pack_id"], name: "index_pack_records_on_pack_id", using: :btree
  add_index "pack_records", ["user_id"], name: "index_pack_records_on_user_id", using: :btree

  create_table "packs", force: :cascade do |t|
    t.string  "name"
    t.text    "description"
    t.text    "action_required"
    t.integer "subject_id",                    null: false
    t.integer "pack_type",         default: 0
    t.integer "priority",          default: 1
    t.integer "number_unassigned", default: 0
    t.integer "number_assigned",   default: 0
  end

  add_index "packs", ["subject_id"], name: "index_packs_on_subject_id", using: :btree

  create_table "packtypes", force: :cascade do |t|
    t.integer "type"
  end

  create_table "subjects", force: :cascade do |t|
    t.string  "subject_name"
    t.float   "fee"
    t.integer "lowest_grade_taught"
    t.integer "highest_grade_taught"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                                             null: false
    t.string   "surname",                                                null: false
    t.datetime "date_of_birth"
    t.string   "role",                                                   null: false
    t.string   "username"
    t.string   "password"
    t.string   "phone_number"
    t.text     "mailing_address"
    t.text     "postal_address",                                         null: false
    t.float    "overdue_fees",           default: 0.0
    t.float    "coupon_value",           default: 0.0
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "email",                  default: "",                    null: false
    t.string   "encrypted_password",     default: "",                    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                     null: false
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
    t.integer  "status",                 default: 0
    t.datetime "activation_date"
    t.float    "rewards",                default: 0.0
    t.float    "total_fees",             default: 0.0
    t.integer  "school_grade",           default: 1
    t.text     "additional_info"
    t.float    "account_balance"
    t.datetime "payment_due",            default: '2016-03-19 00:00:00'
    t.integer  "referrer_count",         default: 0
    t.string   "referrer_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
