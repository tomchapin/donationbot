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

ActiveRecord::Schema.define(version: 20181001174931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "incoming_messages", force: :cascade do |t|
    t.string "to_country"
    t.string "to_state"
    t.string "sms_message_sid"
    t.string "num_media"
    t.string "to_city"
    t.string "from_zip"
    t.string "sms_sid"
    t.string "from_state"
    t.string "sms_status"
    t.string "from_city"
    t.string "body"
    t.string "from_country"
    t.string "to"
    t.string "to_zip"
    t.string "num_segments"
    t.string "message_sid"
    t.string "account_sid"
    t.string "from"
    t.string "api_version"
    t.boolean "processed", default: false
    t.datetime "processed_at"
    t.text "processing_error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "outgoing_slack_messages", force: :cascade do |t|
    t.text "message"
    t.boolean "posted_to_slack"
    t.datetime "posted_to_slack_at"
    t.text "slack_message_id"
    t.bigint "square_cash_fund_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["square_cash_fund_id"], name: "index_outgoing_slack_messages_on_square_cash_fund_id"
  end

  create_table "square_cash_funds", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "phone_number", limit: 20, null: false
    t.string "slack_webhook_url", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "square_cash_transactions", force: :cascade do |t|
    t.bigint "square_cash_fund_id"
    t.string "person_name", limit: 255, null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "message", limit: 255
    t.decimal "balance", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["square_cash_fund_id"], name: "index_square_cash_transactions_on_square_cash_fund_id"
  end

  add_foreign_key "square_cash_transactions", "square_cash_funds"
end
