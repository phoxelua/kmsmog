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

ActiveRecord::Schema.define(version: 20150109215235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "license_plate"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "customers", ["user_id", "name"], name: "index_customers_on_user_id_and_name", using: :btree
  add_index "customers", ["user_id"], name: "index_customers_on_user_id", using: :btree

  create_table "makes", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menus", force: true do |t|
    t.string   "service"
    t.string   "price"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "menus", ["user_id"], name: "index_menus_on_user_id", using: :btree

  create_table "models", force: true do |t|
    t.string   "name"
    t.integer  "make_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "models", ["make_id"], name: "index_models_on_make_id", using: :btree

  create_table "pdf_forms", force: true do |t|
    t.text     "content"
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "file"
  end

  add_index "pdf_forms", ["customer_id", "created_at"], name: "index_pdf_forms_on_customer_id_and_created_at", using: :btree
  add_index "pdf_forms", ["customer_id"], name: "index_pdf_forms_on_customer_id", using: :btree

  create_table "queries", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "license_plate"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "repairs", force: true do |t|
    t.integer  "op"
    t.text     "instruction"
    t.integer  "svc"
    t.integer  "pdf_form_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "repairs", ["pdf_form_id"], name: "index_repairs_on_pdf_form_id", using: :btree

  create_table "trims", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "organization"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
  end

  create_table "years", force: true do |t|
    t.string   "name"
    t.integer  "model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "years", ["model_id"], name: "index_years_on_model_id", using: :btree

end
