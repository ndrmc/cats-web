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

ActiveRecord::Schema.define(version: 20170214161019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "code"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_accounts_on_deleted_at", using: :btree
    t.index ["name", "code"], name: "index_accounts_on_name_and_code", using: :btree
  end

  create_table "bid_plan_items", force: :cascade do |t|
    t.integer  "bid_plan_id"
    t.integer  "woreda_id"
    t.integer  "store_id"
    t.decimal  "quantity"
    t.integer  "unit_of_measure_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_bid_plan_items_on_deleted_at", using: :btree
  end

  create_table "bid_plans", force: :cascade do |t|
    t.string   "year",        null: false
    t.integer  "half_year"
    t.integer  "program_id"
    t.string   "code"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_bid_plans_on_deleted_at", using: :btree
  end

  create_table "bid_submissions", force: :cascade do |t|
    t.integer  "bid_id"
    t.integer  "transporter_id"
    t.decimal  "bid_bond_amount"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_bid_submissions_on_deleted_at", using: :btree
  end

  create_table "bid_winners", force: :cascade do |t|
    t.integer  "bid_id"
    t.integer  "transporter_id"
    t.integer  "store_id"
    t.integer  "destination_id"
    t.decimal  "tariff_amount"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_bid_winners_on_deleted_at", using: :btree
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
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_bids_on_deleted_at", using: :btree
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
    t.float    "max_temperature"
    t.integer  "commodity_category_id"
    t.integer  "unit_of_measure_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["code"], name: "index_commodities_on_code", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_commodities_on_deleted_at", using: :btree
  end

  create_table "commodity_categories", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "code",        null: false
    t.string   "code_am"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "ancestry"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["ancestry"], name: "index_commodity_categories_on_ancestry", using: :btree
    t.index ["code"], name: "index_commodity_categories_on_code", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_commodity_categories_on_deleted_at", using: :btree
  end

  create_table "commodity_sources", force: :cascade do |t|
    t.string   "name"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.boolean  "deleted",     default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.string   "contract_no",  null: false
    t.integer  "transport_id"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_contracts_on_deleted_at", using: :btree
  end

  create_table "currencies", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "symbol"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_currencies_on_deleted_at", using: :btree
    t.index ["name"], name: "index_currencies_on_name", unique: true, using: :btree
  end

  create_table "deliveries", force: :cascade do |t|
    t.string   "receiving_number",                   null: false
    t.integer  "transporter_id",                     null: false
    t.integer  "fdp_id",                             null: false
    t.integer  "gin_number",                         null: false
    t.string   "requisition_number",                 null: false
    t.string   "received_by",                        null: false
    t.date     "received_date",                      null: false
    t.integer  "status"
    t.integer  "operation_id"
    t.text     "remark"
    t.boolean  "draft"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.boolean  "deleted",            default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["gin_number"], name: "index_deliveries_on_gin_number", unique: true, using: :btree
    t.index ["receiving_number"], name: "index_deliveries_on_receiving_number", unique: true, using: :btree
  end

  create_table "delivery_details", force: :cascade do |t|
    t.integer  "commodity_id"
    t.integer  "uom_id"
    t.decimal  "sent_quantity"
    t.decimal  "received_quantity"
    t.integer  "delivery_id"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.boolean  "deleted",           default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "dispatch_items", force: :cascade do |t|
    t.integer  "dispatch_id"
    t.integer  "commodity_category_id"
    t.integer  "commodity_id"
    t.decimal  "quantity"
    t.integer  "project_id"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.boolean  "deleted",               default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["commodity_category_id"], name: "index_dispatch_items_on_commodity_category_id", using: :btree
    t.index ["commodity_id"], name: "index_dispatch_items_on_commodity_id", using: :btree
    t.index ["dispatch_id"], name: "index_dispatch_items_on_dispatch_id", using: :btree
    t.index ["project_id"], name: "index_dispatch_items_on_project_id", using: :btree
  end

  create_table "dispatches", force: :cascade do |t|
    t.string   "gin_no",                                      null: false
    t.integer  "operation_id"
    t.string   "requisition_number"
    t.datetime "dispatch_date"
    t.integer  "fdp_id"
    t.string   "weight_bridge_ticket_number"
    t.integer  "transporter_id"
    t.string   "plate_number"
    t.string   "trailer_plate_number"
    t.string   "drivers_name"
    t.text     "remark"
    t.boolean  "draft",                       default: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.boolean  "deleted",                     default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.index ["fdp_id"], name: "index_dispatches_on_fdp_id", using: :btree
    t.index ["operation_id"], name: "index_dispatches_on_operation_id", using: :btree
    t.index ["transporter_id"], name: "index_dispatches_on_transporter_id", using: :btree
  end

  create_table "donors", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "code",        null: false
    t.boolean  "responsible"
    t.boolean  "source"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["code"], name: "index_donors_on_code", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_donors_on_deleted_at", using: :btree
  end

  create_table "fdp_contacts", force: :cascade do |t|
    t.string   "full_name",   null: false
    t.string   "mobile"
    t.string   "email"
    t.integer  "fdp_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_fdp_contacts_on_deleted_at", using: :btree
  end

  create_table "fdps", force: :cascade do |t|
    t.string   "name",                                  null: false
    t.string   "description"
    t.decimal  "lat",         precision: 15, scale: 13
    t.decimal  "lon",         precision: 15, scale: 13
    t.boolean  "active"
    t.integer  "location_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_fdps_on_deleted_at", using: :btree
  end

  create_table "fscd_annual_plans", force: :cascade do |t|
    t.string   "name",                    null: false
    t.string   "code"
    t.string   "year"
    t.integer  "duration"
    t.integer  "status",      default: 0, null: false
    t.boolean  "archive"
    t.integer  "ration_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_fscd_annual_plans_on_deleted_at", using: :btree
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
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_fscd_plan_items_on_deleted_at", using: :btree
  end

  create_table "fund_sources", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_fund_sources_on_deleted_at", using: :btree
    t.index ["name"], name: "index_fund_sources_on_name", unique: true, using: :btree
  end

  create_table "fund_types", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_fund_types_on_deleted_at", using: :btree
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
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_gift_certificate_items_on_deleted_at", using: :btree
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
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_gift_certificates_on_deleted_at", using: :btree
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
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_hrd_items_on_deleted_at", using: :btree
  end

  create_table "hrds", force: :cascade do |t|
    t.string   "year",                    null: false
    t.integer  "status",      default: 0, null: false
    t.integer  "month_from"
    t.integer  "month_to"
    t.integer  "duration"
    t.boolean  "archived"
    t.boolean  "current"
    t.integer  "season_id"
    t.integer  "ration_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_hrds_on_deleted_at", using: :btree
    t.index ["year", "season_id"], name: "index_hrds_on_year_and_season_id", unique: true, using: :btree
  end

  create_table "hubs", force: :cascade do |t|
    t.string   "name",                                  null: false
    t.string   "description"
    t.decimal  "lat",         precision: 15, scale: 13
    t.decimal  "lon",         precision: 15, scale: 13
    t.integer  "location_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_hubs_on_deleted_at", using: :btree
    t.index ["name"], name: "index_hubs_on_name", unique: true, using: :btree
  end

  create_table "journals", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "code"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.boolean  "deleted",     default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "code"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "ancestry"
    t.integer  "location_type"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["ancestry"], name: "index_locations_on_ancestry", using: :btree
    t.index ["deleted_at"], name: "index_locations_on_deleted_at", using: :btree
  end

  create_table "mode_of_transports", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_mode_of_transports_on_deleted_at", using: :btree
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
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_operations_on_deleted_at", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "long_name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_organizations_on_deleted_at", using: :btree
  end

  create_table "posting_items", force: :cascade do |t|
    t.uuid     "posting_item_code"
    t.integer  "posting_id"
    t.integer  "account_id"
    t.integer  "journal_id"
    t.integer  "donor_id"
    t.integer  "hub_id"
    t.integer  "warehouse_id"
    t.integer  "store_id"
    t.integer  "stack_id"
    t.integer  "project_id"
    t.integer  "batch_id"
    t.integer  "program_id"
    t.integer  "operation_id"
    t.integer  "commodity_id"
    t.integer  "commodity_category_id"
    t.decimal  "quantity"
    t.integer  "region_id"
    t.integer  "zone_id"
    t.integer  "woreda_id"
    t.integer  "fdp_id"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.boolean  "deleted",               default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "postings", force: :cascade do |t|
    t.uuid     "posting_code"
    t.integer  "document_type"
    t.integer  "document_id"
    t.boolean  "posted"
    t.integer  "reversed_posting_id"
    t.integer  "posting_type"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.boolean  "deleted",             default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "programs", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "code",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["code"], name: "index_programs_on_code", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_programs_on_deleted_at", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "project_code"
    t.integer  "commodity_id"
    t.integer  "commodity_source"
    t.integer  "organization_id"
    t.decimal  "amount"
    t.integer  "unit_of_measure_id"
    t.date     "publish_date"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["project_code"], name: "index_projects_on_project_code", using: :btree
  end

  create_table "quotations", force: :cascade do |t|
    t.integer  "bid_submission_id"
    t.integer  "store_id"
    t.integer  "destination_id"
    t.decimal  "tariff_quote"
    t.text     "remark"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_quotations_on_deleted_at", using: :btree
  end

  create_table "ration_items", force: :cascade do |t|
    t.decimal  "amount",             null: false
    t.integer  "ration_id"
    t.integer  "unit_of_measure_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "commodity_id"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_ration_items_on_deleted_at", using: :btree
  end

  create_table "rations", force: :cascade do |t|
    t.string   "reference_no", null: false
    t.string   "description"
    t.boolean  "current"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_rations_on_deleted_at", using: :btree
    t.index ["reference_no"], name: "index_rations_on_reference_no", unique: true, using: :btree
  end

  create_table "receipt_lines", force: :cascade do |t|
    t.integer  "receipt_id"
    t.integer  "commodity_category_id"
    t.integer  "commodity_id"
    t.decimal  "quantity"
    t.integer  "project_id"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.boolean  "deleted",               default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["commodity_category_id"], name: "index_receipt_lines_on_commodity_category_id", using: :btree
    t.index ["commodity_id"], name: "index_receipt_lines_on_commodity_id", using: :btree
    t.index ["project_id"], name: "index_receipt_lines_on_project_id", using: :btree
    t.index ["receipt_id"], name: "index_receipt_lines_on_receipt_id", using: :btree
  end

  create_table "receipts", force: :cascade do |t|
    t.string   "grn_no",                                  null: false
    t.datetime "received_date"
    t.integer  "hub_id"
    t.integer  "warehouse_id"
    t.string   "delivered_by"
    t.integer  "supplier_id"
    t.integer  "transporter_id"
    t.string   "plate_no"
    t.string   "trailer_plate_no"
    t.string   "weight_bridge_ticket_no"
    t.decimal  "weight_before_unloading"
    t.decimal  "weight_after_unloading"
    t.string   "storekeeper_name"
    t.string   "waybill_no"
    t.string   "purchase_request_no"
    t.string   "purchase_order_no"
    t.string   "invoice_no"
    t.integer  "commodity_source_id"
    t.integer  "program_id"
    t.integer  "store_id"
    t.string   "drivers_name"
    t.text     "remark"
    t.boolean  "draft",                   default: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.boolean  "deleted",                 default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["commodity_source_id"], name: "index_receipts_on_commodity_source_id", using: :btree
    t.index ["hub_id"], name: "index_receipts_on_hub_id", using: :btree
    t.index ["program_id"], name: "index_receipts_on_program_id", using: :btree
    t.index ["store_id"], name: "index_receipts_on_store_id", using: :btree
    t.index ["supplier_id"], name: "index_receipts_on_supplier_id", using: :btree
    t.index ["transporter_id"], name: "index_receipts_on_transporter_id", using: :btree
    t.index ["warehouse_id"], name: "index_receipts_on_warehouse_id", using: :btree
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
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_requisition_items_on_deleted_at", using: :btree
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
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_requisitions_on_deleted_at", using: :btree
    t.index ["requisition_no"], name: "index_requisitions_on_requisition_no", unique: true, using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_roles_on_deleted_at", using: :btree
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "seasons", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_seasons_on_deleted_at", using: :btree
    t.index ["name"], name: "index_seasons_on_name", unique: true, using: :btree
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name",              null: false
    t.boolean  "temporary"
    t.integer  "warehouse_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.string   "store_keeper_name"
    t.index ["deleted_at"], name: "index_stores_on_deleted_at", using: :btree
    t.index ["name", "warehouse_id"], name: "index_stores_on_name_and_warehouse_id", unique: true, using: :btree
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name",                        null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.boolean  "deleted",     default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
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
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_transport_order_items_on_deleted_at", using: :btree
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
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_transport_orders_on_deleted_at", using: :btree
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
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_transport_requisition_items_on_deleted_at", using: :btree
  end

  create_table "transport_requisitions", force: :cascade do |t|
    t.integer  "region_id"
    t.integer  "operation_id"
    t.date     "created_date"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_transport_requisitions_on_deleted_at", using: :btree
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
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_transporter_addresses_on_deleted_at", using: :btree
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
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_transporters_on_deleted_at", using: :btree
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
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["code"], name: "index_unit_of_measures_on_code", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_unit_of_measures_on_deleted_at", using: :btree
  end

  create_table "uom_categories", force: :cascade do |t|
    t.string   "name",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_uom_categories_on_deleted_at", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "language"
    t.string   "keyboard"
    t.string   "calendar"
    t.string   "default_uom"
    t.string   "region"
    t.string   "organization_unit"
    t.string   "hub"
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.boolean  "is_active",              default: true
    t.string   "first_name"
    t.string   "last_name"
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer  "created_by"
    t.integer  "modified_by"
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_roles_on_deleted_at", using: :btree
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "warehouses", force: :cascade do |t|
    t.string   "name",                                      null: false
    t.string   "description"
    t.integer  "hub_id"
    t.integer  "location_id"
    t.integer  "organization_id"
    t.decimal  "lat",             precision: 15, scale: 13
    t.decimal  "lon",             precision: 15, scale: 13
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_warehouses_on_deleted_at", using: :btree
  end

end
