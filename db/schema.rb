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

ActiveRecord::Schema.define(:version => 20090309182205) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["item_id"], :name => "index_activities_on_item_id"
  add_index "activities", ["item_type"], :name => "index_activities_on_item_type"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "boards", :force => true do |t|
    t.integer  "user_id"
    t.integer  "boarder_id"
    t.string   "content"
    t.string   "reply"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "shops_count",    :default => 0
    t.integer  "products_count", :default => 0
    t.string   "belongs_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["belongs_to"], :name => "index_categories_on_belongs_to"
  add_index "categories", ["name"], :name => "index_categories_on_name"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "entry_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reply"
    t.integer  "photo_id"
  end

  create_table "entries", :force => true do |t|
    t.integer  "user_id"
    t.integer  "entry_category_id"
    t.integer  "blog_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count"
  end

  add_index "entries", ["entry_category_id"], :name => "index_entries_on_entry_category_id"
  add_index "entries", ["user_id"], :name => "index_entries_on_user_id"

  create_table "entry_categories", :force => true do |t|
    t.string   "name"
    t.integer  "entries_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entry_categories", ["name"], :name => "index_entry_categories_on_name"

  create_table "event_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_categories", ["name"], :name => "index_event_categories_on_name"

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_category_id"
    t.string   "title"
    t.string   "city"
    t.integer  "people"
    t.integer  "money"
    t.text     "term"
    t.text     "introduction"
    t.text     "notes"
    t.integer  "status"
    t.string   "location"
    t.datetime "started_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
  end

  add_index "events", ["event_category_id"], :name => "index_events_on_event_category_id"
  add_index "events", ["title"], :name => "index_events_on_title"

  create_table "events_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "phone"
    t.integer  "members_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events_users", ["event_id"], :name => "index_events_users_on_event_id"
  add_index "events_users", ["user_id"], :name => "index_events_users_on_user_id"

  create_table "forums", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "topics_count", :default => 0
    t.integer  "posts_count",  :default => 0
    t.integer  "last_post"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forums", ["title"], :name => "index_forums_on_title"

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.boolean  "is_friend",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friend_id"], :name => "index_friendships_on_friend_id"
  add_index "friendships", ["user_id"], :name => "index_friendships_on_user_id"

  create_table "galleries", :force => true do |t|
    t.integer  "user_id"
    t.integer  "photos_count", :default => 0, :null => false
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "galleries", ["user_id"], :name => "index_galleries_on_user_id"

  create_table "information", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.boolean  "sex"
    t.string   "birthday"
    t.string   "blood"
    t.integer  "height"
    t.integer  "weight"
    t.string   "style"
    t.string   "from"
    t.string   "location"
    t.string   "job"
    t.string   "company"
    t.string   "rank"
    t.string   "school"
    t.string   "educational"
    t.string   "belief"
    t.string   "dress"
    t.boolean  "drink",       :default => false
    t.boolean  "smoke",       :default => false
    t.string   "personality"
    t.string   "hobiy"
    t.string   "qq"
    t.string   "msn"
    t.string   "telephone"
    t.string   "mobilephone"
    t.string   "mailadress"
    t.string   "zipcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "information", ["user_id"], :name => "index_information_on_user_id"

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "parent_id"
    t.string   "title"
    t.string   "content"
    t.datetime "sender_deleted_at"
    t.datetime "recipient_deleted_at"
    t.datetime "replied_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["recipient_id"], :name => "index_messages_on_recipient_id"
  add_index "messages", ["sender_id"], :name => "index_messages_on_sender_id"

  create_table "photos", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "gallery_id"
    t.integer  "user_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.boolean  "primary"
    t.boolean  "avatar"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count"
    t.string   "title"
    t.string   "description"
    t.integer  "shop_id"
    t.integer  "product_id"
  end

  add_index "photos", ["parent_id"], :name => "index_photos_on_parent_id"
  add_index "photos", ["product_id"], :name => "index_photos_on_product_id"
  add_index "photos", ["shop_id"], :name => "index_photos_on_shop_id"
  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["topic_id"], :name => "index_posts_on_topic_id"

  create_table "products", :force => true do |t|
    t.integer  "shop_id"
    t.integer  "category_id"
    t.integer  "counts"
    t.string   "belongs_to"
    t.string   "name"
    t.string   "address"
    t.text     "introduction"
    t.text     "offer_description"
    t.text     "reservation_help"
    t.boolean  "is_recommend",                                                   :default => false
    t.integer  "price",             :limit => 10, :precision => 10, :scale => 0
    t.float    "discount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["category_id", "shop_id"], :name => "index_products_on_category_id_and_shop_id"
  add_index "products", ["name"], :name => "index_products_on_name"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shops", :force => true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "products_count"
    t.integer  "category_parent"
    t.string   "shopname"
    t.string   "surename"
    t.string   "IDcard"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.string   "postcode"
    t.integer  "status"
    t.boolean  "is_recomend",     :default => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shops", ["category_id"], :name => "index_shops_on_category_id"
  add_index "shops", ["shopname"], :name => "index_shops_on_shopname"

  create_table "spaces", :force => true do |t|
    t.integer  "user_id"
    t.string   "address"
    t.string   "titlee"
    t.text     "description"
    t.string   "resolution"
    t.string   "composition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "styles", :force => true do |t|
    t.integer  "user_id"
    t.string   "stylename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "styles", ["stylename"], :name => "index_styles_on_stylename"
  add_index "styles", ["user_id"], :name => "index_styles_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "topic_categories", :force => true do |t|
    t.integer  "forum_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topic_categories", ["name"], :name => "index_topic_categories_on_name"

  create_table "topics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "forum_id"
    t.integer  "topic_category_id"
    t.string   "title"
    t.text     "content"
    t.integer  "posts_count",       :default => 0
    t.integer  "views_count",       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"
  add_index "topics", ["title"], :name => "index_topics_on_title"
  add_index "topics", ["topic_category_id"], :name => "index_topics_on_topic_category_id"

  create_table "usermodels", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "profile_model", :default => true
    t.boolean  "board_model",   :default => true
    t.boolean  "article_model", :default => true
    t.boolean  "friend_model",  :default => true
    t.boolean  "entry_model",   :default => true
    t.boolean  "album_model",   :default => true
    t.boolean  "visit_model",   :default => true
    t.boolean  "space_model",   :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usermodels", ["user_id"], :name => "index_usermodels_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "nike"
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "last_activity"
    t.datetime "last_activity_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entries_count",    :default => 0
    t.integer  "views_count",      :default => 0
    t.integer  "galleries_count"
    t.integer  "comments_count"
    t.integer  "photos_count",     :default => 0
    t.string   "profile"
  end

  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "visits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "guest_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visits", ["guest_id"], :name => "index_visits_on_guest_id"
  add_index "visits", ["user_id"], :name => "index_visits_on_user_id"

end
