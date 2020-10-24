class BookAuthor < ApplicationRecord
  belongs_to :book
  belongs_to :author

  validates :ISBN, :authorKey, presence: true
  validates :ISBN, :authorKey, uniqueness: true
  validates_associated :book
  validates_associated :author
end
