class Book < ApplicationRecord
  belongs_to :category
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :rental_books
  has_many :customers, through: :rental_books

  validates :ISBN, :title, :bookURL, presence: true
  validates :ISBN, uniqueness: true
  validates :numberOfPages, numericality: { only_integer: true }, allow_nil: true
end
