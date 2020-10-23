class Book < ApplicationRecord
  has_many :book_authors
  has_many :author, through: :book_authors
end
