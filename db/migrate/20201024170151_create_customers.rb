class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :street_address
      t.string :state
      t.string :country
      t.string :postcode
      t.string :latitude
      t.string :longtitude

      t.timestamps
    end
  end
end
