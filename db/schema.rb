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

ActiveRecord::Schema.define(version: 20161113182319) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bid_plan_items", force: :cascade do |t|
    t.integer  "bid_plan_id"
    t.integer  "woreda_id"
    t.integer  "store_id"
    t.decimal  "quantity"
    t.integer  "unit_of_measure_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "bid_plans", force: :cascade do |t|
    t.string   "year",        null: false
    t.integer  "half_year"
    t.integer  "program_id"
    t.string   "code"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "bid_submissions", force: :cascade do |t|
    t.integer  "bid_id"
    t.integer  "transporter_id"
    t.decimal  "bid_bond_amount"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "bid_winners", force: :cascade do |t|
    t.integer  "bid_id"
    t.integer  "transporter_id"
    t.integer  "store_id"
    t.integer  "destination_id"
    t.decimal  "tariff_amount"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "bids", force: :cascade do |t|
    t.string   "bid_no",                         null: false
    t.date     "start_date"
    t.date     "end_date"
    t.text     "description"
    t.date     "opening_date"
    t.integer  "status",             default: 0, null: false
    t.integer  "bid_plan_id"
    t.integer  "region_id"
    t.decimal  "document_price"
    t.decimal  "cpo_deposit_amount"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "commodities", force: :cascade do |t|
    t.string   "name",                  null: false
    t.string   "name_am"
    t.string   "long_name"
    t.string   "code",                  null: false
    t.string   "code_am"
    t.text     "description"
    t.boolean  "hazardous"
    t.boolean  "cold_storage"
    t.float    "min_temperature"
    t.float    "mix_temperature"
    t.integer  "commodity_category_id"
    t.integer  "unit_of_measure_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["code"], name: "index_commodities_on_code", unique: true, using: :btree
  end

  create_table "commodity_categories", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "code",        null: false
    t.string   "code_am"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "ancestry"
    t.index ["ancestry"], name: "index_commodity_categories_on_ancestry", using: :btree
    t.index ["code"], name: "index_commodity_categories_on_code", unique: true, using: :btree
  end

  create_table "contracts", force: :cascade do |t|
    t.string   "contract_no",  null: false
    t.integer  "transport_id"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "symbol"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_currencies_on_name", unique: true, using: :btree
  end

  create_table "donors", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "code",        null: false
    t.boolean  "responsible"
    t.boolean  "source"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["code"], name: "index_donors_on_code", unique: true, using: :btree
  end

  create_table "fdp_contacts", force: :cascade do |t|
    t.string   "full_name",  null: false
    t.string   "mobile"
    t.string   "email"
    t.integer  "fdp_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fdps", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.float    "lat"
    t.float    "lon"
    t.boolean  "active"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "fscd_annual_plans", force: :cascade do |t|
    t.string   "name",                   null: false
    t.string   "code"
    t.string   "year"
    t.integer  "duration"
    t.integer  "status",     default: 0, null: false
    t.boolean  "archive"
    t.integer  "ration_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["year"], name: "index_fscd_annual_plans_on_year", unique: true, using: :btree
  end

  create_table "fscd_plan_items", force: :cascade do |t|
    t.integer  "beneficiary_no",      null: false
    t.integer  "fscd_annual_plan_id"
    t.integer  "woreda_id",           null: false
    t.integer  "starting_month"
    t.integer  "food_ratio"
    t.integer  "cash_ratio"
    t.boolean  "contingency"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "fund_sources", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_fund_sources_on_name", unique: true, using: :btree
  end

  create_table "fund_types", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_fund_types_on_name", unique: true, using: :btree
  end

  create_table "gift_certificate_items", force: :cascade do |t|
    t.integer  "gift_certificate_id"
    t.integer  "commodity_id"
    t.integer  "fund_source_id"
    t.integer  "unit_of_measure_id"
    t.integer  "currency_id"
    t.float    "amount",              null: false
    t.float    "estimated_value"
    t.float    "estimated_tax"
    t.date     "expiry_date"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "gift_certificates", force: :cascade do |t|
    t.string   "reference_no",                       null: false
    t.date     "gift_date"
    t.string   "vessel"
    t.integer  "donor_id"
    t.date     "eta"
    t.integer  "program_id"
    t.integer  "mode_of_transport_id"
    t.string   "port_name"
    t.integer  "status",                 default: 0, null: false
    t.string   "customs_declaration_no"
    t.string   "bill_of_ladding"
    t.float    "amount"
    t.float    "estimated_price"
    t.float    "estimated_tax"
    t.string   "purchase_year"
    t.date     "expiry_date"
    t.integer  "fund_type_id"
    t.string   "account_no"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["reference_no"], name: "index_gift_certificates_on_reference_no", unique: true, using: :btree
  end

  create_table "hrd_items", force: :cascade do |t|
    t.integer  "hrd_id"
    t.integer  "woreda_id"
    t.integer  "duration"
    t.integer  "starting_month"
    t.integer  "beneficiary"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "hrds", force: :cascade do |t|
    t.string   "year",                   null: false
    t.integer  "status",     default: 0, null: false
    t.integer  "month_from"
    t.integer  "month_to"
    t.integer  "duration"
    t.boolean  "archived"
    t.boolean  "current"
    t.integer  "season_id"
    t.integer  "ration_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["year", "season_id"], name: "index_hrds_on_year_and_season_id", unique: true, using: :btree
  end

  create_table "hubs", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_hubs_on_name", unique: true, using: :btree
  end

  create_table "location_types", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_location_types_on_name", unique: true, using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",             null: false
    t.string   "code"
    t.integer  "location_type_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "ancestry"
    t.index ["ancestry"], name: "index_locations_on_ancestry", using: :btree
  end

  create_table "mode_of_transports", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_mode_of_transports_on_name", unique: true, using: :btree
  end

  create_table "operations", force: :cascade do |t|
    t.integer  "program_id"
    t.integer  "hrd_id"
    t.integer  "fscd_annual_plan_id"
    t.string   "name",                            null: false
    t.text     "descripiton"
    t.string   "year"
    t.integer  "round"
    t.integer  "month"
    t.date     "expected_start"
    t.date     "expected_end"
    t.date     "actual_start"
    t.date     "actual_end"
    t.integer  "status",              default: 0, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "programs", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "code",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["code"], name: "index_programs_on_code", unique: true, using: :btree
  end

  create_table "quotations", force: :cascade do |t|
    t.integer  "bid_submission_id"
    t.integer  "store_id"
    t.integer  "destination_id"
    t.decimal  "tariff_quote"
    t.text     "remark"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "ration_items", force: :cascade do |t|
    t.decimal  "amount",             null: false
    t.integer  "ration_id"
    t.integer  "unit_of_measure_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "commodity_id"
  end

  create_table "rations", force: :cascade do |t|
    t.string   "reference_no", null: false
    t.string   "description"
    t.boolean  "current"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["reference_no"], name: "index_rations_on_reference_no", unique: true, using: :btree
  end

  create_table "requisition_items", force: :cascade do |t|
    t.integer  "requisition_id"
    t.integer  "commodity_id"
    t.integer  "unit_of_measure_id"
    t.integer  "fdp_id"
    t.integer  "beneficiary_no",     null: false
    t.decimal  "amount",             null: false
    t.decimal  "contingency"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "requisitions", force: :cascade do |t|
    t.string   "requisition_no",             null: false
    t.integer  "operation_id"
    t.integer  "commodity_id"
    t.integer  "region_id"
    t.integer  "zone_id"
    t.integer  "ration_id"
    t.string   "requested_by"
    t.date     "requested_on"
    t.integer  "status",         default: 0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["requisition_no"], name: "index_requisitions_on_requisition_no", unique: true, using: :btree
  end

  create_table "seasons", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_seasons_on_name", unique: true, using: :btree
  end

  create_table "store_locations", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.integer  "hub_id"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "store_owners", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "long_name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name",              null: false
    t.boolean  "temporary"
    t.integer  "hub_id"
    t.integer  "store_owner_id"
    t.integer  "store_location_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["name", "hub_id"], name: "index_stores_on_name_and_hub_id", unique: true, using: :btree
  end

  create_table "transport_order_items", force: :cascade do |t|
    t.integer  "transport_order_id"
    t.integer  "fdp_id"
    t.integer  "store_id"
    t.integer  "commodity_id"
    t.decimal  "quantity"
    t.integer  "unit_of_measure_id"
    t.decimal  "tariff"
    t.string   "requisition_no"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "transport_orders", force: :cascade do |t|
    t.string   "order_no"
    t.integer  "transporter_id"
    t.integer  "contract_id"
    t.integer  "bid_id"
    t.integer  "operation_id"
    t.integer  "region_id"
    t.date     "order_date"
    t.date     "created_date"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "performance_bond_receipt"
    t.decimal  "performance_bond_amount"
    t.integer  "printed_copies",           default: 0, null: false
    t.integer  "status",                   default: 0, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "transport_requisition_items", force: :cascade do |t|
    t.integer  "transport_requisition_item_id"
    t.string   "requisition_no"
    t.integer  "fdp_id"
    t.integer  "commodity_id"
    t.decimal  "quantity"
    t.boolean  "has_transport_order"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "transport_requisitions", force: :cascade do |t|
    t.integer  "region_id"
    t.integer  "operation_id"
    t.date     "created_date"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "transporter_addresses", force: :cascade do |t|
    t.integer  "transporter_id"
    t.integer  "region_id"
    t.integer  "zone_id"
    t.integer  "woreda_id"
    t.string   "subcity"
    t.string   "kebele"
    t.string   "house_no"
    t.string   "phone"
    t.string   "mobile"
    t.string   "email"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "transporters", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "code",                      null: false
    t.string   "ownership"
    t.integer  "vehicle_count"
    t.decimal  "lift_capacity"
    t.decimal  "capital"
    t.integer  "employees"
    t.string   "contact"
    t.string   "contact_phone"
    t.text     "remark"
    t.integer  "status",        default: 0, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "unit_of_measures", force: :cascade do |t|
    t.string   "name",                                                null: false
    t.string   "description"
    t.string   "code",                                                null: false
    t.integer  "uom_type",                                default: 0, null: false
    t.decimal  "ratio",           precision: 8, scale: 2,             null: false
    t.integer  "uom_category_id"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.index ["code"], name: "index_unit_of_measures_on_code", unique: true, using: :btree
  end

  create_table "uom_categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "name",                                null: false
    t.string   "language"
    t.string   "keyboard"
    t.string   "calendar"
    t.string   "default_uom"
    t.string   "region"
    t.string   "organization_unit"
    t.string   "hub"
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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
