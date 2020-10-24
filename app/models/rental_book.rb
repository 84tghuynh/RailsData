class RentalBook < ApplicationRecord
  belongs_to :book
  belongs_to :customer

  validates :rental_date, presence: true
end
