class CreateRentalBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :rental_books do |t|
      t.references :book, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.datetime :rental_date

      t.timestamps
    end
  end
end
