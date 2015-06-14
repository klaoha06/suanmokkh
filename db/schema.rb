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

ActiveRecord::Schema.define(version: 20150613091927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
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
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "language"
    t.string   "series"
    t.string   "group"
    t.date     "publication_date"
    t.boolean  "draft",              default: false
    t.boolean  "featured",           default: false
    t.boolean  "allow_comments",     default: true
    t.integer  "reads",              default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "articles_authors", id: false, force: :cascade do |t|
    t.integer "author_id"
    t.integer "article_id"
  end

  add_index "articles_authors", ["article_id"], name: "index_articles_authors_on_article_id", using: :btree
  add_index "articles_authors", ["author_id"], name: "index_articles_authors_on_author_id", using: :btree

  create_table "articles_publishers", id: false, force: :cascade do |t|
    t.integer "publisher_id"
    t.integer "article_id"
  end

  add_index "articles_publishers", ["article_id"], name: "index_articles_publishers_on_article_id", using: :btree
  add_index "articles_publishers", ["publisher_id"], name: "index_articles_publishers_on_publisher_id", using: :btree

  create_table "audios", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "language"
    t.string   "series"
    t.string   "group"
    t.date     "creation_date"
    t.string   "duration"
    t.text     "embeded_audio_link"
    t.text     "external_link"
    t.boolean  "draft",              default: false
    t.boolean  "featured",           default: false
    t.boolean  "allow_comments",     default: true
    t.integer  "downloads",          default: 0
    t.integer  "plays",              default: 0
    t.integer  "shares",             default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "audios_authors", id: false, force: :cascade do |t|
    t.integer "audio_id"
    t.integer "author_id"
  end

  add_index "audios_authors", ["audio_id"], name: "index_audios_authors_on_audio_id", using: :btree
  add_index "audios_authors", ["author_id"], name: "index_audios_authors_on_author_id", using: :btree

  create_table "audios_books", id: false, force: :cascade do |t|
    t.integer "audio_id"
    t.integer "book_id"
  end

  add_index "audios_books", ["audio_id"], name: "index_audios_books_on_audio_id", using: :btree
  add_index "audios_books", ["book_id"], name: "index_audios_books_on_book_id", using: :btree

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "brief_biography"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "authors_books", id: false, force: :cascade do |t|
    t.integer "author_id"
    t.integer "book_id"
  end

  add_index "authors_books", ["author_id"], name: "index_authors_books_on_author_id", using: :btree
  add_index "authors_books", ["book_id"], name: "index_authors_books_on_book_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "external_link"
    t.string   "language"
    t.string   "series"
    t.string   "group"
    t.date     "creation_date"
    t.string   "isbn_10"
    t.string   "isbn_13"
    t.date     "publication_date"
    t.boolean  "draft",                                          default: false
    t.boolean  "featured",                                       default: false
    t.boolean  "allow_comments",                                 default: true
    t.string   "format"
    t.float    "weight"
    t.integer  "pages"
    t.decimal  "price",                  precision: 8, scale: 2
    t.integer  "downloads",                                      default: 0
    t.integer  "views",                                          default: 1
    t.integer  "shares",                                         default: 0
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.string   "cover_img_file_name"
    t.string   "cover_img_content_type"
    t.integer  "cover_img_file_size"
    t.datetime "cover_img_updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "books_publishers", id: false, force: :cascade do |t|
    t.integer "publisher_id"
    t.integer "book_id"
  end

  add_index "books_publishers", ["book_id"], name: "index_books_publishers_on_book_id", using: :btree
  add_index "books_publishers", ["publisher_id"], name: "index_books_publishers_on_publisher_id", using: :btree

  create_table "catagories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "news_articles", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "language"
    t.integer  "views"
    t.boolean  "draft",                  default: false
    t.boolean  "featured",               default: false
    t.boolean  "allow_comments",         default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "cover_img_file_name"
    t.string   "cover_img_content_type"
    t.integer  "cover_img_file_size"
    t.datetime "cover_img_updated_at"
  end

  create_table "poems", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "author"
    t.string   "language"
    t.string   "series"
    t.string   "group"
    t.date     "creation_date"
    t.integer  "views"
    t.boolean  "draft",                  default: false
    t.boolean  "featured",               default: false
    t.boolean  "allow_comments",         default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "cover_img_file_name"
    t.string   "cover_img_content_type"
    t.integer  "cover_img_file_size"
    t.datetime "cover_img_updated_at"
  end

  create_table "publishers", force: :cascade do |t|
    t.string   "name"
    t.integer  "book_id"
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "publishers", ["article_id"], name: "index_publishers_on_article_id", using: :btree
  add_index "publishers", ["book_id"], name: "index_publishers_on_book_id", using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "language"
    t.integer  "downloads",         default: 0
    t.integer  "plays",             default: 0
    t.string   "series"
    t.string   "group"
    t.string   "publisher"
    t.boolean  "draft",             default: false
    t.boolean  "featured",          default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

end
