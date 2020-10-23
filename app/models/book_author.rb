class BookAuthor < ApplicationRecord
  belongs_to :book
  belongs_to :author

  validates :ISBN, :authorKey, presence: true
  validates uniqueness:{scope: :ISBN, :authorKey}
end
