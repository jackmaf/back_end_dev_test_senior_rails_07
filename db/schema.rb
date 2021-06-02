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

ActiveRecord::Schema.define(version: 2021_06_02_013121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.string "plate_vehicle"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.string "id_wompi"
    t.integer "amount"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trip_id"], name: "index_payments_on_trip_id"
  end

  create_table "riders", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "rider_id", null: false
    t.bigint "driver_id", null: false
    t.string "lat_ini"
    t.string "lng_ini"
    t.string "lat_end"
    t.string "lng_end"
    t.integer "distance_km"
    t.integer "minutes"
    t.integer "base_fee"
    t.integer "total_fee"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["driver_id"], name: "index_trips_on_driver_id"
    t.index ["rider_id"], name: "index_trips_on_rider_id"
  end

  add_foreign_key "payments", "trips"
  add_foreign_key "trips", "drivers"
  add_foreign_key "trips", "riders"
end
