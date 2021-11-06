# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_05_083847) do

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bills", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "month_id", null: false
    t.integer "account_id", null: false
    t.integer "year"
    t.float "price"
    t.text "detail"
    t.integer "category_id", null: false
    t.integer "subcategoryid"
    t.integer "further_subcategoryid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_bills_on_account_id"
    t.index ["category_id"], name: "index_bills_on_category_id"
    t.index ["month_id"], name: "index_bills_on_month_id"
    t.index ["user_id"], name: "index_bills_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "ancestry"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ancestry"], name: "index_categories_on_ancestry"
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "months", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users_accounts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_users_accounts_on_account_id"
    t.index ["user_id"], name: "index_users_accounts_on_user_id"
  end

  create_table "users_bills", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "bill_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bill_id"], name: "index_users_bills_on_bill_id"
    t.index ["user_id"], name: "index_users_bills_on_user_id"
  end

  add_foreign_key "bills", "accounts"
  add_foreign_key "bills", "categories"
  add_foreign_key "bills", "months"
  add_foreign_key "bills", "users"
  add_foreign_key "users_accounts", "accounts"
  add_foreign_key "users_accounts", "users"
  add_foreign_key "users_bills", "bills"
  add_foreign_key "users_bills", "users"
end
