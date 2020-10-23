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

def link_fetch(link)
  JSON.parse(URI.open(link).read)
end

def build_link_publisher(publisher)
  "http://openlibrary.org/search.json?publisher=#{publisher}"
end

def get_book_data(book)
  puts (book["title_suggest"]).to_s
  puts "ISBN: #{book['isbn'][0]}"
end

# link = "http://openlibrary.org/search.json?q=Ballantine+Books"
# link = "http://openlibrary.org/search.json?publisher=%22Ballantine%20Books%22"
# books = link_fetch(build_link_publisher("Wadsworth Thomson Learning"))

publishers = ["Ballantine Books", "Pearson Prentice Hall", "Wadsworth Thomson Learning"]
i = 0
publishers.each do |publisher|
  books = link_fetch(build_link_publisher(publisher))
  books["docs"].each do |book|
    next if book["isbn"].nil?

    puts i.to_s
    get_book_data(book)
    i += 1
  end
end
