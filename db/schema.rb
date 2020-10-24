# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_24_170748) do

  create_table "authors", force: :cascade do |t|
    t.string "authorKey"
    t.string "name"
    t.string "personalName"
    t.text "bio"
    t.text "cover_s"
    t.text "cover_m"
    t.text "cover_l"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "book_authors", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "author_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ISBN"
    t.string "authorKey"
    t.index ["author_id"], name: "index_book_authors_on_author_id"
    t.index ["book_id"], name: "index_book_authors_on_book_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "ISBN"
    t.string "title"
    t.text "description"
    t.string "publisher"
    t.string "publishDate"
    t.integer "numberOfPages"
    t.text "bookURL"
    t.text "cover_s"
    t.text "cover_m"
    t.text "cover_l"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "category_id", null: false
    t.index ["category_id"], name: "index_books_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "street_address"
    t.string "state"
    t.string "country"
    t.string "postcode"
    t.string "latitude"
    t.string "longtitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rental_books", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "customer_id", null: false
    t.datetime "rental_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_rental_books_on_book_id"
    t.index ["customer_id"], name: "index_rental_books_on_customer_id"
  end

  add_foreign_key "book_authors", "authors"
  add_foreign_key "book_authors", "books"
  add_foreign_key "books", "categories"
  add_foreign_key "rental_books", "books"
  add_foreign_key "rental_books", "customers"
end
