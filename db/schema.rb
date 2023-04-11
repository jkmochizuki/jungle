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

ActiveRecord::Schema.define(version: 2023_04_11_020929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.integer "item_price_cents"
    t.integer "total_price_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
  end

  create_table "options", id: :serial, force: :cascade do |t|
    t.integer "poll_id"
    t.text "description", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "total_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "stripe_charge_id"
    t.string "email"
  end

  create_table "polls", id: :serial, force: :cascade do |t|
    t.integer "creator_id"
    t.string "title", limit: 255, null: false
    t.string "question", limit: 255, null: false
    t.datetime "date_created", default: -> { "now()" }, null: false
    t.datetime "date_completed"
    t.boolean "complete", default: false, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.integer "price_cents"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "product_id"
    t.integer "user_id"
    t.text "description"
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.integer "voter_id"
    t.integer "poll_id"
    t.integer "option_id"
    t.integer "rank_position", limit: 2, null: false
  end

  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "options", "polls", name: "options_poll_id_fkey", on_delete: :cascade
  add_foreign_key "products", "categories"
  add_foreign_key "votes", "options", name: "votes_option_id_fkey", on_delete: :cascade
  add_foreign_key "votes", "polls", name: "votes_poll_id_fkey", on_delete: :cascade
end
