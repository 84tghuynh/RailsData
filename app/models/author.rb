class Author < ApplicationRecord
  has_many :book_authors
  has_many :books, through: :book_authors

  validates :authorKey, :name, presence: true
  validates :authorKey, uniqueness: true
end
