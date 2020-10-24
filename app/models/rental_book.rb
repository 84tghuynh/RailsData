class RentalBook < ApplicationRecord
  belongs_to :book
  belongs_to :customer
end
