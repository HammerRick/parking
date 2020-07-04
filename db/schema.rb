# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_04_171358) do

  create_table "cars", force: :cascade do |t|
    t.string "model"
    t.string "brand"
    t.string "color"
    t.string "plate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plate"], name: "index_cars_on_plate", unique: true
  end

  create_table "parking_tickets", force: :cascade do |t|
    t.datetime "in_at"
    t.datetime "out_at"
    t.boolean "paid"
    t.integer "car_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_parking_tickets_on_car_id"
  end

  add_foreign_key "parking_tickets", "cars"
end
