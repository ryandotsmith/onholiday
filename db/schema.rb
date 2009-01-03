# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090103033547) do

  create_table "holidays", :force => true do |t|
    t.integer  "user_id"
    t.string   "approved_by"
    t.datetime "approved_on"
    t.datetime "begin"
    t.datetime "end"
    t.boolean  "health"
    t.boolean  "personal"
    t.boolean  "vacation"
    t.boolean  "emergency"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "name"
    t.integer  "max_personal"
    t.integer  "max_vacation"
    t.integer  "max_health"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
