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

ActiveRecord::Schema.define(version: 20170512065059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "admins_roles", id: false, force: :cascade do |t|
    t.integer "admin_id"
    t.integer "role_id"
    t.index ["admin_id", "role_id"], name: "index_admins_roles_on_admin_id_and_role_id", using: :btree
  end

  create_table "checkpoints", force: :cascade do |t|
    t.string   "name"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_checkpoints_on_team_id", using: :btree
  end

  create_table "clues", force: :cascade do |t|
    t.string   "name"
    t.integer  "day"
    t.integer  "points"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "clue_references", default: [],              array: true
    t.text     "description"
    t.string   "clue_subject"
  end

  create_table "contracts", force: :cascade do |t|
    t.integer  "money_output", default: 0
    t.integer  "info_output",  default: [],              array: true
    t.integer  "item_output",  default: [],              array: true
    t.string   "name"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "upkeep"
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "type"
    t.integer  "value"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "owned_contracts", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "contract_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["contract_id"], name: "index_owned_contracts_on_contract_id", using: :btree
    t.index ["team_id"], name: "index_owned_contracts_on_team_id", using: :btree
  end

  create_table "owned_properties", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "property_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["property_id"], name: "index_owned_properties_on_property_id", using: :btree
    t.index ["team_id"], name: "index_owned_properties_on_team_id", using: :btree
  end

  create_table "properties", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "money_output"
    t.integer  "info_output"
    t.integer  "district"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "quests", force: :cascade do |t|
    t.string   "quest_name"
    t.text     "description"
    t.integer  "day"
    t.string   "quest_type"
    t.integer  "money_output"
    t.integer  "item_output"
    t.integer  "dependent_on"
    t.integer  "unlocks"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "red_output"
    t.integer  "blue_output"
    t.integer  "green_output"
    t.integer  "orange_output"
    t.integer  "clue_output"
  end

  create_table "recieved_clues", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "clue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clue_id"], name: "index_recieved_clues_on_clue_id", using: :btree
    t.index ["team_id"], name: "index_recieved_clues_on_team_id", using: :btree
  end

  create_table "recieved_quests", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "quest_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quest_id"], name: "index_recieved_quests_on_quest_id", using: :btree
    t.index ["team_id"], name: "index_recieved_quests_on_team_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "phone_num"
    t.integer  "money"
    t.integer  "blue_info"
    t.integer  "red_info"
    t.integer  "green_info"
    t.integer  "orange_info"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.datetime "next_upkeep_hour"
    t.datetime "last_contacted"
    t.integer  "outstanding_payout", default: [],              array: true
    t.string   "faction"
    t.string   "carrier"
    t.integer  "net_worth"
    t.string   "guild_name"
  end

  add_foreign_key "checkpoints", "teams"
  add_foreign_key "owned_contracts", "contracts"
  add_foreign_key "owned_contracts", "teams"
  add_foreign_key "owned_properties", "properties"
  add_foreign_key "owned_properties", "teams"
  add_foreign_key "recieved_clues", "clues"
  add_foreign_key "recieved_clues", "teams"
  add_foreign_key "recieved_quests", "quests"
  add_foreign_key "recieved_quests", "teams"
end
