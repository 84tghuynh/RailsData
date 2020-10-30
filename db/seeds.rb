# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "json"

# puts URI.open("https://swapi.dev/api/people/1/").read
# puts URI.open("http://openlibrary.org/search.json?q=Ballantine+Books").read

# link = "http://openlibrary.org/search.json?q=Ballantine+Books"
# link = "http://openlibrary.org/search.json?publisher=%22Ballantine%20Books%22"
# books = link_fetch(build_link_publisher("Wadsworth Thomson Learning"))

# BookAuthor.delete_all
# RentalBook.delete_all
# Book.delete_all
# Author.delete_all

# Category.delete_all

def link_fetch(link)
  JSON.parse(URI.open(link).read)
end

def build_link_publisher(publisher)
  "http://openlibrary.org/search.json?publisher=#{publisher}"
end

def build_link_book(isbn)
  "https://openlibrary.org/api/books?bibkeys=ISBN:#{isbn}&jscmd=details&format=json"
end

def build_link_author(authorKey)
  "https://openlibrary.org/authors/#{authorKey}.json"
end

# work: /works/OL103196W
def build_link_work(work)
  "https://openlibrary.org#{work}.json"
end

######################################################
# Print functions
#####################################################

def print_get_author_details(authorKey)
  unless authorKey.nil?

    author_details = link_fetch(build_link_author(authorKey))

    unless author_details.nil?
      puts "authorKey: #{authorKey}"
      puts "name: #{author_details['name']} "
      puts "personame: #{author_details['personal_name']} "

      if !author_details["bio"].nil?
        puts "bio: #{author_details['bio']['value']} "
      else
        puts "bio:"
      end
      puts "cover_s: http://covers.openlibrary.org/a/olid/#{authorKey}-S.jpg "
      puts "cover_m: http://covers.openlibrary.org/a/olid/#{authorKey}-M.jpg"
      puts "cover_l: http://covers.openlibrary.org/a/olid/#{authorKey}-L.jpg"
    end

  end
end

# print_get_author_details("OL24137A")

def print_get_description_from_work(work)
  unless work.nil?
    work_details = link_fetch(build_link_work(work))

    work_details["description"]["value"] unless work_details["description"].nil?
  end
end

# print_get_description_from_work("/works/OL103196W")

def print_get_book_details(book)
  book_details = link_fetch(build_link_book(book["isbn"][0]))

  puts "ISBN: #{book['isbn'][0]}"

  work = book_details["ISBN:#{book['isbn'][0]}"]["details"]["works"][0]["key"]

  puts "Title: #{book_details["ISBN:#{book['isbn'][0]}"]['details']['title']}"
  puts "Description(work): #{print_get_description_from_work(work)}"
  puts "Publisher: #{book_details["ISBN:#{book['isbn'][0]}"]['details']['publishers'][0]}"
  puts "PublisDate: #{book_details["ISBN:#{book['isbn'][0]}"]['details']['publish_date']} "
  puts "numberOfPages: #{book_details["ISBN:#{book['isbn'][0]}"]['details']['number_of_pages']}"
  puts "bookURL: #{book_details["ISBN:#{book['isbn'][0]}"]['info_url']}"

  if !book_details["ISBN:#{book['isbn'][0]}"]["details"]["covers"].nil?
    puts "cover_s: #{book_details["ISBN:#{book['isbn'][0]}"]['details']['covers'][0]}"
    puts "cover_m: http://covers.openlibrary.org/b/id/#{book_details["ISBN:#{book['isbn'][0]}"]['details']['covers'][0]}-M.jpg"
    puts "cover_l: http://covers.openlibrary.org/b/id/#{book_details["ISBN:#{book['isbn'][0]}"]['details']['covers'][0]}-L.jpg"
  else
    puts "cover_s:"
    puts "cover_m:"
    puts "cover_l:"
  end
end

def print_get_list_book_details
  # publishers = ["Ballantine Books", "Pearson Prentice Hall", "Wadsworth Thomson Learning"]
  publishers = ["Ballantine Books"]
  i = 0
  publishers.each do |publisher|
    books = link_fetch(build_link_publisher(publisher))
    # puts books["docs"]
    books["docs"].each do |book|
      next if book["isbn"].nil?

      puts i.to_s
      puts "Author: #{book['author_key'][0]} "
      print_get_author_details(book["author_key"][0])
      print_get_book_details(book)
      i += 1
    end
  end
end

# print_get_list_book_details

##################################################
# Populating functions
##################################################
def get_author_details_and_create(authorKey)
  unless authorKey.nil?

    author_details = link_fetch(build_link_author(authorKey))

    unless author_details.nil?

      name = author_details["name"]
      personalname = author_details["personal_name"]

      bio = ""
      bio = author_details["bio"]["value"] unless author_details["bio"].nil?
      cover_s = "http://covers.openlibrary.org/a/olid/#{authorKey}-S.jpg"
      cover_m = "http://covers.openlibrary.org/a/olid/#{authorKey}-M.jpg"
      cover_l = "http://covers.openlibrary.org/a/olid/#{authorKey}-L.jpg"

      create_author(authorKey, name, personalname, bio, cover_s, cover_m, cover_l)
    end

  end
end

def create_author(authorKey, name, personalname, bio, cover_s, cover_m, cover_l)
  puts "Create Author"
  Author.find_or_create_by(authorKey: authorKey) do |author|
    author.name = name
    author.personalName = personalname
    author.bio = bio
    author.cover_s = cover_s
    author.cover_m = cover_m
    author.cover_l = cover_l
  end
end

def get_description_from_work(work)
  unless work.nil?
    work_details = link_fetch(build_link_work(work))

    work_details["description"]["value"] unless work_details["description"].nil?
  end
end

def get_book_details_and_create(book)
  puts "get_book_details_and_create ISBN #{book['isbn'][0]}"
  book_details = link_fetch(build_link_book(book["isbn"][0]))

  work = book_details["ISBN:#{book['isbn'][0]}"]["details"]["works"][0]["key"]

  isbn = book["isbn"][0]
  title = book_details["ISBN:#{book['isbn'][0]}"]["details"]["title"]
  description = get_description_from_work(work)
  publisher = book_details["ISBN:#{book['isbn'][0]}"]["details"]["publishers"][0]
  publishDate = book_details["ISBN:#{book['isbn'][0]}"]["details"]["publish_date"]
  numberOfPages = book_details["ISBN:#{book['isbn'][0]}"]["details"]["number_of_pages"]
  bookURL = book_details["ISBN:#{book['isbn'][0]}"]["info_url"]

  cover_s = ""
  cover_m = ""
  cover_l = ""

  unless book_details["ISBN:#{book['isbn'][0]}"]["details"]["covers"].nil?
    cover_s = "http://covers.openlibrary.org/b/id/#{book_details["ISBN:#{book['isbn'][0]}"]['details']['covers'][0]}-S.jpg"
    cover_m = "http://covers.openlibrary.org/b/id/#{book_details["ISBN:#{book['isbn'][0]}"]['details']['covers'][0]}-M.jpg"
    cover_l = "http://covers.openlibrary.org/b/id/#{book_details["ISBN:#{book['isbn'][0]}"]['details']['covers'][0]}-L.jpg"
  end

  # puts "title: #{title}"
  # puts "work: #{work}"
  # puts "description: #{description}"

  create_book(isbn, title, description, publisher, publishDate, numberOfPages, bookURL, cover_s, cover_m, cover_l)
end

def create_book(isbn, title, description, publisher, publishDate, numberOfPages, bookURL, cover_s, cover_m, cover_l)
  puts "Create book"

  random_offset = rand(10)
  category = Category.offset(random_offset).first
  # puts "------Before Find or create category #{category.name}, then create book"
  if category&.valid?
    # Find the isbn or create a new one with a
    category.books.find_or_create_by(ISBN: isbn) do |book|
      book.title = title
      book.description = description
      book.publisher = publisher
      book.publishDate = publishDate
      book.numberOfPages = numberOfPages
      book.bookURL = bookURL
      book.cover_s = cover_s
      book.cover_m = cover_m
      book.cover_l = cover_l
    end
  end
end

def create_category_faker
  puts "Create Categories"
  10.times do
    Category.create(name: Faker::Book.unique.genre, description: Faker::Quote.unique.matz)
  end
end

# create_category_faker

def check_associtaion
  puts "Check Associations"
  Book.first.authors.each do |a|
    puts a.name
  end
end
# check_associtaion

def create_customer_faker
  puts "Creates 100 customer"

  100.times do
    Customer.create(name:           Faker::Name.unique.name,
                    street_address: Faker::Address.unique.street_name,
                    state:          Faker::Address.state,
                    country:        Faker::Address.country,
                    postcode:       Faker::Address.postcode,
                    latitude:       Faker::Address.latitude,
                    longtitude:     Faker::Address.longitude)
  end
end
# create_customer_faker

def create_rentalbook
  puts "Populates 100 rentalbooks records"

  customer_count = Customer.count
  book_count = Book.count

  100.times do
    random_offset_customer = rand(customer_count)
    customer = Customer.offset(random_offset_customer).first

    random_offset_book = rand(book_count)
    book = Book.offset(random_offset_book).first

    RentalBook.create(book_id:     book.id,
                      customer_id: customer.id,
                      rental_date: Faker::Time.between(from: DateTime.now - 40, to: DateTime.now))
  end
end

# create_rentalbook

def get_create_books_authors
  # publishers = ["Ballantine Books", "Pearson Prentice Hall", "Wadsworth Thomson Learning"]
  publishers = ["Ballantine Books"]
  # publishers = ["Pearson Prentice Hall"]
  # publishers = ["Wadsworth Thomson Learning"]
  i = 0
  publishers.each do |publisher|
    books = link_fetch(build_link_publisher(publisher))
    # puts books["docs"]
    books["docs"].each do |b|
      next if b["isbn"].nil?

      puts i.to_s
      # puts "Author: #{book['author_key'][0]} "
      # get_author_details(book["author_key"][0])
      new_book = get_book_details_and_create(b)

      unless new_book.nil?
        j = 0
        b["author_key"].each do |a|
          puts "#{j}. Author: #{a} "
          author = get_author_details_and_create(a)

          # puts "Create BookAuthors #{book.id}"
          # unless book.nil?
          BookAuthor.create(book_id: new_book.id, author_id: author.id, ISBN: b["isbn"][0], authorKey: a)
          # end
          j += 1
        end
      end

      i += 1
    end
  end
  puts "Created Books: #{Book.count}"
  puts "Created Author: #{Author.count}"
  puts "Created BookAuthor: #{BookAuthor.count}"
end

def create_bookauthors
  puts "Populates 100 BookAuthors records"

  Book.all.each do |book|
    puts "Books: #{book.ISBN}"
    book_details = link_fetch(build_link_book(book.ISBN))

    puts book_details["ISBN:#{book.ISBN}"]["details"]["authors"][0]

    # each do |author|
    #  puts "Author: #{author.key}"
    # end
  end
end

# BookAuthor.delete_all
# RentalBook.delete_all
# Book.delete_all
# Author.delete_all
# Category.delete_all

####################################################
#  How to populate the data
####################################################
# Step 1: Populates 10 Categories - To prepare category_id for Step 3
# create_category_faker

# Step 2: Populates 100 Customers - To prepare customer_id for step 4
# create_customer_faker

# Step 3:  Populates books, authors, bookauthors

########################################
#  Endpoints
#   + build_link_publisher(publisher) : "http://openlibrary.org/search.json?publisher=#{publisher}"
#   + build_link_book(isbn): "https://openlibrary.org/api/books?bibkeys=ISBN:#{isbn}&jscmd=details&format=json"
#   + build_link_author(authorKey): "https://openlibrary.org/authors/#{authorKey}.json"
#   + build_link_work(work): (work: /works/OL103196W)   "https://openlibrary.org#{work}.json"
#
##########################################

# get_create_books_authors

# Step 4: Populates RentalBooks
create_rentalbook
