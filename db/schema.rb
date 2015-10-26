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

ActiveRecord::Schema.define(version: 20151026025856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "people", force: :cascade do |t|
    t.string   "first_name"
    t.string   "surname"
    t.datetime "date_of_birth"
    t.string   "email"
    t.string   "role"
    t.string   "username"
    t.string   "password"
    t.string   "phone_number"
    t.string   "mailing_address"
    t.string   "postal_address"
    t.integer  "number_of_enrolments"
    t.float    "overdue_fees"
    t.float    "coupon_value"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "persons", force: :cascade do |t|
    t.string   "first_name",           null: false
    t.string   "surname",              null: false
    t.datetime "date_of_birth",        null: false
    t.string   "email"
    t.string   "role",                 null: false
    t.string   "username",             null: false
    t.string   "password",             null: false
    t.string   "phone_number"
    t.text     "mailing_address",      null: false
    t.text     "postal_address"
    t.integer  "number_of_enrolments"
    t.float    "overdue_fees"
    t.float    "coupon_value"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",           null: false
    t.string   "surname",              null: false
    t.datetime "date_of_birth",        null: false
    t.string   "email"
    t.string   "role",                 null: false
    t.string   "username",             null: false
    t.string   "password",             null: false
    t.string   "phone_number"
    t.text     "mailing_address",      null: false
    t.text     "postal_address"
    t.integer  "number_of_enrolments"
    t.float    "overdue_fees"
    t.float    "coupon_value"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
