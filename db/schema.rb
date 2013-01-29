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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130129155222) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "adresses", :force => true do |t|
    t.string   "title"
    t.string   "last_name"
    t.string   "country"
    t.string   "adress1"
    t.string   "adress2"
    t.string   "city"
    t.string   "county"
    t.integer  "zip"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "adress_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "active",      :default => false
    t.string   "first_name"
  end

  create_table "article_set_likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "article_set_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "article_sets", :force => true do |t|
    t.string   "name"
    t.integer  "user_id",                       :null => false
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count", :default => 0
    t.integer  "likes_count",    :default => 0
  end

  create_table "assets", :force => true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "carts", :force => true do |t|
    t.datetime "purchased_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
  end

  create_table "categories_products", :id => false, :force => true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizations", :force => true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "article_set_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["article_set_id"], :name => "comments_article_set_id_fk"
  add_index "comments", ["user_id"], :name => "comments_user_id_fk"

  create_table "countries", :force => true do |t|
    t.string  "iso"
    t.string  "name"
    t.string  "printable_name"
    t.string  "iso3"
    t.integer "numcode"
  end

  create_table "images", :force => true do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "img"
  end

  add_index "images", ["product_id"], :name => "images_product_id_fk"

  create_table "line_items", :force => true do |t|
    t.integer  "unit_price",    :default => 0, :null => false
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stock_item_id"
  end

  add_index "line_items", ["cart_id"], :name => "line_items_cart_id_fk"

  create_table "order_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_transactions", :force => true do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "cart_id"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "adress1"
    t.string   "adress2"
    t.string   "zipcode"
    t.string   "city"
    t.string   "country"
    t.string   "card_type"
    t.date     "card_expires_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "express_token"
    t.string   "express_payer_id"
    t.integer  "shipping_method_id"
    t.integer  "user_id"
    t.string   "order_nr"
    t.integer  "order_status_id",    :default => 1
    t.string   "phone"
  end

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.string   "status"
    t.string   "transaction_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_likes", ["product_id"], :name => "product_likes_product_id_fk"
  add_index "product_likes", ["user_id"], :name => "product_likes_user_id_fk"

  create_table "product_translations", :force => true do |t|
    t.integer  "product_id"
    t.string   "locale"
    t.string   "title"
    t.string   "subtitle"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_translations", ["product_id"], :name => "index_product_translations_on_product_id"

  create_table "products", :force => true do |t|
    t.text     "description"
    t.integer  "price",        :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "subtitle"
    t.string   "currency",     :default => "GBP"
    t.boolean  "legacy",       :default => false
    t.string   "product_code"
    t.integer  "category_id"
  end

  create_table "products_wishlists", :id => false, :force => true do |t|
    t.integer "product_id"
    t.integer "wishlist_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "set_items", :force => true do |t|
    t.integer  "article_set_id"
    t.integer  "product_id"
    t.integer  "pos_x"
    t.integer  "pos_y"
    t.integer  "width"
    t.integer  "height"
    t.integer  "z_index"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rotation"
    t.string   "url"
  end

  create_table "shipping_methods", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_shares", :force => true do |t|
    t.string   "email"
    t.string   "sender_mail"
    t.string   "sender_name"
    t.string   "name"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "start_images", :force => true do |t|
    t.string   "link"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stock_items", :force => true do |t|
    t.integer  "product_id"
    t.string   "color"
    t.string   "size"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "item_code"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",   :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "password_salt"
    t.string   "password_hash"
    t.boolean  "admin"
    t.string   "locale",                                :default => "en"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wishlists", :force => true do |t|
    t.integer  "user_id"
    t.string   "product_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "comments", "article_sets", :name => "comments_article_set_id_fk", :dependent => :delete
  add_foreign_key "comments", "users", :name => "comments_user_id_fk", :dependent => :delete

  add_foreign_key "images", "products", :name => "images_product_id_fk", :dependent => :delete

  add_foreign_key "line_items", "carts", :name => "line_items_cart_id_fk", :dependent => :delete

  add_foreign_key "product_likes", "products", :name => "product_likes_product_id_fk", :dependent => :delete
  add_foreign_key "product_likes", "users", :name => "product_likes_user_id_fk", :dependent => :delete

end
