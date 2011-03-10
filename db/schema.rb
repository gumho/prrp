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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110310005037) do

  create_table "award_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campus_winners", :force => true do |t|
    t.integer  "proposal_id"
    t.integer  "term_id"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "proposal_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "current_terms", :force => true do |t|
    t.integer  "term_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "doc_file_name"
    t.integer  "proposal_id"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.date     "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposals", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "term_id"
    t.boolean  "reviewed",          :default => false
    t.integer  "award_category_id"
    t.boolean  "assigned",          :default => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     :default => false
    t.date     "begin"
    t.date     "end"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.string   "perishable_token",  :default => "",    :null => false
    t.boolean  "active",            :default => false, :null => false
    t.integer  "organization_id"
    t.string   "first_name"
    t.string   "last_name"
  end

end
