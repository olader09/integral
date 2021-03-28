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

ActiveRecord::Schema.define(version: 20210328161324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dishes", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "picture"
    t.jsonb "categories"
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visible", default: true
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.string "order_queue", default: ""
    t.decimal "total", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "confirmed", default: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "orders_dishes", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "dish_id"
    t.integer "quantity", default: 1
    t.index ["dish_id"], name: "index_orders_dishes_on_dish_id"
    t.index ["order_id"], name: "index_orders_dishes_on_order_id"
  end

  create_table "superusers", force: :cascade do |t|
    t.string "login", null: false
    t.string "password_digest"
    t.string "role", default: "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "phone_number", null: false
    t.string "role", default: "user"
    t.jsonb "cart"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
