class Book < ApplicationRecord
  has_many :book_authors
  has_many :author, through: :book_authors

  validates :ISBN, :title, :bookURL, presence: true
  validates :ISBN, uniqueness: true
  validates :numberOfPages, numericality: { only_integer: true }, allow_nil: true
end
