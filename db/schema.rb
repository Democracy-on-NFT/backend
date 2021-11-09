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

ActiveRecord::Schema.define(version: 2021_11_09_101711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deputies", force: :cascade do |t|
    t.string "name"
    t.string "image_link"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "deputy_legislatures", force: :cascade do |t|
    t.bigint "deputy_id"
    t.bigint "legislature_id"
    t.bigint "electoral_circumscription_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deputy_id"], name: "index_deputy_legislatures_on_deputy_id"
    t.index ["electoral_circumscription_id"], name: "index_deputy_legislatures_on_electoral_circumscription_id"
    t.index ["legislature_id"], name: "index_deputy_legislatures_on_legislature_id"
  end

  create_table "deputy_parties", force: :cascade do |t|
    t.bigint "deputy_id"
    t.bigint "party_id"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deputy_id"], name: "index_deputy_parties_on_deputy_id"
    t.index ["party_id"], name: "index_deputy_parties_on_party_id"
  end

  create_table "draft_decisions", force: :cascade do |t|
    t.string "number"
    t.date "date"
    t.text "title"
    t.bigint "deputy_legislature_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deputy_legislature_id"], name: "index_draft_decisions_on_deputy_legislature_id"
  end

  create_table "electoral_circumscriptions", force: :cascade do |t|
    t.string "county_name"
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "legislative_initiatives", force: :cascade do |t|
    t.string "number"
    t.date "date"
    t.text "title"
    t.bigint "deputy_legislature_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deputy_legislature_id"], name: "index_legislative_initiatives_on_deputy_legislature_id"
  end

  create_table "legislatures", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "offices", force: :cascade do |t|
    t.text "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "deputy_id"
    t.index ["deputy_id"], name: "index_offices_on_deputy_id"
  end

  create_table "parties", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "party_legislatures", force: :cascade do |t|
    t.bigint "party_id"
    t.bigint "legislature_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["legislature_id"], name: "index_party_legislatures_on_legislature_id"
    t.index ["party_id"], name: "index_party_legislatures_on_party_id"
  end

  create_table "signed_motions", force: :cascade do |t|
    t.text "title"
    t.string "number"
    t.date "date"
    t.integer "status", limit: 2
    t.bigint "deputy_legislature_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deputy_legislature_id"], name: "index_signed_motions_on_deputy_legislature_id"
  end

  create_table "speeches", force: :cascade do |t|
    t.text "title"
    t.date "date"
    t.bigint "deputy_legislature_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deputy_legislature_id"], name: "index_speeches_on_deputy_legislature_id"
  end

  add_foreign_key "draft_decisions", "deputy_legislatures"
  add_foreign_key "legislative_initiatives", "deputy_legislatures"
  add_foreign_key "offices", "deputies"
  add_foreign_key "signed_motions", "deputy_legislatures"
  add_foreign_key "speeches", "deputy_legislatures"
end
