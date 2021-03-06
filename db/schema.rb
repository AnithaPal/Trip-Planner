# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150916173401) do

  create_table "expenses", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "user_id"
    t.string   "category"
    t.integer  "amount_spent"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "expenses", ["trip_id"], name: "index_expenses_on_trip_id"
  add_index "expenses", ["user_id"], name: "index_expenses_on_user_id"

  create_table "invites", force: :cascade do |t|
    t.string   "email"
    t.integer  "trip_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "token"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "status",       default: "sent"
  end

  add_index "invites", ["trip_id"], name: "index_invites_on_trip_id"

  create_table "poll_options", force: :cascade do |t|
    t.string   "title"
    t.integer  "poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "poll_options", ["poll_id"], name: "index_poll_options_on_poll_id"

  create_table "polls", force: :cascade do |t|
    t.text     "topic"
    t.integer  "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "polls", ["trip_id"], name: "index_polls_on_trip_id"

  create_table "trippers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "trippers", ["trip_id", "user_id"], name: "index_trippers_on_trip_id_and_user_id", unique: true
  add_index "trippers", ["trip_id"], name: "index_trippers_on_trip_id"
  add_index "trippers", ["user_id"], name: "index_trippers_on_user_id"

  create_table "trips", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "start_date"
    t.text     "end_date"
  end

  add_index "trips", ["user_id"], name: "index_trips_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "poll_option_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "votes", ["poll_option_id", "user_id"], name: "index_votes_on_poll_option_id_and_user_id", unique: true
  add_index "votes", ["poll_option_id"], name: "index_votes_on_poll_option_id"
  add_index "votes", ["user_id"], name: "index_votes_on_user_id"

end
