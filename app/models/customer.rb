class Customer < ApplicationRecord
  has_many :rental_books
  has_many :books, through: :rental_books

  validates :name, :street_address, presence: true
  validates :name, :street_address, uniqueness: true
end
