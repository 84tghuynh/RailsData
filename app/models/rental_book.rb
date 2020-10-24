class RentalBook < ApplicationRecord
  belongs_to :book
  belongs_to :customer

  validates :rental_date, presence: true
  validates_associated :book
  validates_associated :customer
end
