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

ActiveRecord::Schema[7.1].define(version: 2025_01_30_140234) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_categories_on_lower_name", unique: true
  end

  create_table "ingredients", force: :cascade do |t|
    t.uuid "receipe_id", null: false
    t.uuid "product_item_id", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_item_id"], name: "index_ingredients_on_product_item_id"
    t.index ["receipe_id", "product_item_id"], name: "index_ingredients_on_receipe_id_and_product_item_id", unique: true
    t.index ["receipe_id"], name: "index_ingredients_on_receipe_id"
  end

  create_table "product_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.binary "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "unit_id"
    t.index ["name"], name: "index_product_items_on_name", unique: true
    t.index ["unit_id"], name: "index_product_items_on_unit_id"
  end

  create_table "receipes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.integer "portions_number", default: 1, null: false
    t.binary "illustration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.string "slug"
    t.index ["slug"], name: "index_receipes_on_slug", unique: true
    t.index ["title"], name: "index_receipes_on_title", unique: true
    t.index ["user_id"], name: "index_receipes_on_user_id"
  end

  create_table "units", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "plural"
    t.string "abbreviation"
    t.string "variants", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abbreviation"], name: "index_units_on_abbreviation", unique: true
    t.index ["name"], name: "index_units_on_name", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "ingredients", "product_items"
  add_foreign_key "ingredients", "receipes"
  add_foreign_key "product_items", "units"
  add_foreign_key "receipes", "users"
end
