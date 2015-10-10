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

ActiveRecord::Schema.define(version: 20151010173537) do

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
    t.string   "username",               default: "", null: false
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
    t.text     "content_or_description"
    t.date     "creation_date"
    t.text     "external_url_link"
    t.text     "external_cover_img_link"
    t.text     "external_file_link"
    t.string   "series"
    t.date     "publication_date"
    t.boolean  "draft",                   default: false
    t.boolean  "featured",                default: false
    t.boolean  "recommended",             default: false
    t.boolean  "allow_comments",          default: true
    t.integer  "views",                   default: 0
    t.integer  "shares",                  default: 0
    t.integer  "admin_user_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "cover_img_file_name"
    t.string   "cover_img_content_type"
    t.integer  "cover_img_file_size"
    t.datetime "cover_img_updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "articles", ["admin_user_id"], name: "index_articles_on_admin_user_id", using: :btree

  create_table "articles_authors", id: false, force: :cascade do |t|
    t.integer "author_id"
    t.integer "article_id"
  end

  add_index "articles_authors", ["article_id"], name: "index_articles_authors_on_article_id", using: :btree
  add_index "articles_authors", ["author_id"], name: "index_articles_authors_on_author_id", using: :btree

  create_table "articles_groups", id: false, force: :cascade do |t|
    t.integer "article_id"
    t.integer "group_id"
  end

  add_index "articles_groups", ["article_id"], name: "index_articles_groups_on_article_id", using: :btree
  add_index "articles_groups", ["group_id"], name: "index_articles_groups_on_group_id", using: :btree

  create_table "articles_languages", id: false, force: :cascade do |t|
    t.integer "article_id"
    t.integer "language_id"
  end

  add_index "articles_languages", ["article_id"], name: "index_articles_languages_on_article_id", using: :btree
  add_index "articles_languages", ["language_id"], name: "index_articles_languages_on_language_id", using: :btree

  create_table "articles_publishers", id: false, force: :cascade do |t|
    t.integer "publisher_id"
    t.integer "article_id"
  end

  add_index "articles_publishers", ["article_id"], name: "index_articles_publishers_on_article_id", using: :btree
  add_index "articles_publishers", ["publisher_id"], name: "index_articles_publishers_on_publisher_id", using: :btree

  create_table "audios", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "series"
    t.date     "creation_date"
    t.string   "duration"
    t.string   "audio_code"
    t.text     "embeded_audio_link"
    t.text     "external_link"
    t.boolean  "draft",              default: false
    t.boolean  "featured",           default: false
    t.boolean  "recommended",        default: false
    t.boolean  "allow_comments",     default: true
    t.integer  "downloads",          default: 0
    t.integer  "plays",              default: 0
    t.integer  "shares",             default: 0
    t.integer  "admin_user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "audios", ["admin_user_id"], name: "index_audios_on_admin_user_id", using: :btree

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

  create_table "audios_groups", id: false, force: :cascade do |t|
    t.integer "audio_id"
    t.integer "group_id"
  end

  add_index "audios_groups", ["audio_id"], name: "index_audios_groups_on_audio_id", using: :btree
  add_index "audios_groups", ["group_id"], name: "index_audios_groups_on_group_id", using: :btree

  create_table "audios_languages", id: false, force: :cascade do |t|
    t.integer "audio_id"
    t.integer "language_id"
  end

  add_index "audios_languages", ["audio_id"], name: "index_audios_languages_on_audio_id", using: :btree
  add_index "audios_languages", ["language_id"], name: "index_audios_languages_on_language_id", using: :btree

  create_table "audios_retreat_talks", id: false, force: :cascade do |t|
    t.integer "audio_id"
    t.integer "retreat_talk_id"
  end

  add_index "audios_retreat_talks", ["audio_id"], name: "index_audios_retreat_talks_on_audio_id", using: :btree
  add_index "audios_retreat_talks", ["retreat_talk_id"], name: "index_audios_retreat_talks_on_retreat_talk_id", using: :btree

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

  create_table "authors_poems", id: false, force: :cascade do |t|
    t.integer "author_id"
    t.integer "poem_id"
  end

  add_index "authors_poems", ["author_id"], name: "index_authors_poems_on_author_id", using: :btree
  add_index "authors_poems", ["poem_id"], name: "index_authors_poems_on_poem_id", using: :btree

  create_table "authors_retreat_talks", id: false, force: :cascade do |t|
    t.integer "author_id"
    t.integer "retreat_talk_id"
  end

  add_index "authors_retreat_talks", ["author_id"], name: "index_authors_retreat_talks_on_author_id", using: :btree
  add_index "authors_retreat_talks", ["retreat_talk_id"], name: "index_authors_retreat_talks_on_retreat_talk_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "external_url_link"
    t.text     "external_cover_img_link"
    t.text     "external_file_link"
    t.string   "language"
    t.string   "series"
    t.string   "group"
    t.date     "creation_date"
    t.string   "isbn_10"
    t.string   "isbn_13"
    t.date     "publication_date"
    t.boolean  "draft",                                           default: false
    t.boolean  "featured",                                        default: false
    t.boolean  "allow_comments",                                  default: true
    t.boolean  "recommended",                                     default: false
    t.string   "format"
    t.float    "weight"
    t.integer  "pages"
    t.decimal  "price",                   precision: 8, scale: 2
    t.string   "currency"
    t.integer  "downloads",                                       default: 0
    t.integer  "views",                                           default: 0
    t.integer  "shares",                                          default: 0
    t.integer  "admin_user_id"
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.string   "cover_img_file_name"
    t.string   "cover_img_content_type"
    t.integer  "cover_img_file_size"
    t.datetime "cover_img_updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "books", ["admin_user_id"], name: "index_books_on_admin_user_id", using: :btree

  create_table "books_groups", id: false, force: :cascade do |t|
    t.integer "book_id"
    t.integer "group_id"
  end

  add_index "books_groups", ["book_id"], name: "index_books_groups_on_book_id", using: :btree
  add_index "books_groups", ["group_id"], name: "index_books_groups_on_group_id", using: :btree

  create_table "books_languages", id: false, force: :cascade do |t|
    t.integer "book_id"
    t.integer "language_id"
  end

  add_index "books_languages", ["book_id"], name: "index_books_languages_on_book_id", using: :btree
  add_index "books_languages", ["language_id"], name: "index_books_languages_on_language_id", using: :btree

  create_table "books_publishers", id: false, force: :cascade do |t|
    t.integer "publisher_id"
    t.integer "book_id"
  end

  add_index "books_publishers", ["book_id"], name: "index_books_publishers_on_book_id", using: :btree
  add_index "books_publishers", ["publisher_id"], name: "index_books_publishers_on_publisher_id", using: :btree

  create_table "books_retreat_talks", id: false, force: :cascade do |t|
    t.integer "book_id"
    t.integer "retreat_talk_id"
  end

  add_index "books_retreat_talks", ["book_id"], name: "index_books_retreat_talks_on_book_id", using: :btree
  add_index "books_retreat_talks", ["retreat_talk_id"], name: "index_books_retreat_talks_on_retreat_talk_id", using: :btree

  create_table "catagories", force: :cascade do |t|
    t.string   "name"
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

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.date     "date"
    t.text     "external_cover_img_link"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "cover_img_file_name"
    t.string   "cover_img_content_type"
    t.integer  "cover_img_file_size"
    t.datetime "cover_img_updated_at"
  end

  create_table "groups_languages", id: false, force: :cascade do |t|
    t.integer "group_id"
    t.integer "language_id"
  end

  add_index "groups_languages", ["group_id"], name: "index_groups_languages_on_group_id", using: :btree
  add_index "groups_languages", ["language_id"], name: "index_groups_languages_on_language_id", using: :btree

  create_table "groups_news_articles", id: false, force: :cascade do |t|
    t.integer "group_id"
    t.integer "news_article_id"
  end

  add_index "groups_news_articles", ["group_id"], name: "index_groups_news_articles_on_group_id", using: :btree
  add_index "groups_news_articles", ["news_article_id"], name: "index_groups_news_articles_on_news_article_id", using: :btree

  create_table "groups_poems", id: false, force: :cascade do |t|
    t.integer "poem_id"
    t.integer "group_id"
  end

  add_index "groups_poems", ["group_id"], name: "index_groups_poems_on_group_id", using: :btree
  add_index "groups_poems", ["poem_id"], name: "index_groups_poems_on_poem_id", using: :btree

  create_table "groups_retreat_talks", id: false, force: :cascade do |t|
    t.integer "retreat_talk_id"
    t.integer "group_id"
  end

  add_index "groups_retreat_talks", ["group_id"], name: "index_groups_retreat_talks_on_group_id", using: :btree
  add_index "groups_retreat_talks", ["retreat_talk_id"], name: "index_groups_retreat_talks_on_retreat_talk_id", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages_news_articles", id: false, force: :cascade do |t|
    t.integer "language_id"
    t.integer "news_article_id"
  end

  add_index "languages_news_articles", ["language_id"], name: "index_languages_news_articles_on_language_id", using: :btree
  add_index "languages_news_articles", ["news_article_id"], name: "index_languages_news_articles_on_news_article_id", using: :btree

  create_table "languages_poems", id: false, force: :cascade do |t|
    t.integer "poem_id"
    t.integer "language_id"
  end

  add_index "languages_poems", ["language_id"], name: "index_languages_poems_on_language_id", using: :btree
  add_index "languages_poems", ["poem_id"], name: "index_languages_poems_on_poem_id", using: :btree

  create_table "languages_retreat_talks", id: false, force: :cascade do |t|
    t.integer "retreat_talk_id"
    t.integer "language_id"
  end

  add_index "languages_retreat_talks", ["language_id"], name: "index_languages_retreat_talks_on_language_id", using: :btree
  add_index "languages_retreat_talks", ["retreat_talk_id"], name: "index_languages_retreat_talks_on_retreat_talk_id", using: :btree

  create_table "news_articles", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "author"
    t.boolean  "draft",                  default: false
    t.boolean  "featured",               default: false
    t.boolean  "allow_comments",         default: true
    t.integer  "admin_user_id"
    t.integer  "views",                  default: 0
    t.integer  "shares",                 default: 0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "cover_img_file_name"
    t.string   "cover_img_content_type"
    t.integer  "cover_img_file_size"
    t.datetime "cover_img_updated_at"
  end

  add_index "news_articles", ["admin_user_id"], name: "index_news_articles_on_admin_user_id", using: :btree

  create_table "poems", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "author"
    t.string   "series"
    t.date     "creation_date"
    t.integer  "views",                  default: 0
    t.integer  "shares",                 default: 0
    t.boolean  "draft",                  default: false
    t.boolean  "featured",               default: false
    t.boolean  "allow_comments",         default: true
    t.integer  "admin_user_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "cover_img_file_name"
    t.string   "cover_img_content_type"
    t.integer  "cover_img_file_size"
    t.datetime "cover_img_updated_at"
  end

  add_index "poems", ["admin_user_id"], name: "index_poems_on_admin_user_id", using: :btree

  create_table "publishers", force: :cascade do |t|
    t.string   "name"
    t.text     "contact_info"
    t.integer  "book_id"
    t.integer  "article_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "publishers", ["article_id"], name: "index_publishers_on_article_id", using: :btree
  add_index "publishers", ["book_id"], name: "index_publishers_on_book_id", using: :btree

  create_table "retreat_talks", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "series"
    t.string   "duration"
    t.string   "audio_code"
    t.text     "embeded_audio_link"
    t.text     "external_url_link"
    t.text     "external_cover_img_link"
    t.string   "language"
    t.string   "group"
    t.date     "publication_date"
    t.boolean  "draft",                   default: false
    t.boolean  "featured",                default: false
    t.boolean  "allow_comments",          default: true
    t.boolean  "recommended",             default: false
    t.string   "format"
    t.integer  "downloads",               default: 0
    t.integer  "views",                   default: 0
    t.integer  "shares",                  default: 0
    t.integer  "admin_user_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "cover_img_file_name"
    t.string   "cover_img_content_type"
    t.integer  "cover_img_file_size"
    t.datetime "cover_img_updated_at"
  end

  add_index "retreat_talks", ["admin_user_id"], name: "index_retreat_talks_on_admin_user_id", using: :btree

  create_table "users", force: :cascade do |t|
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

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
