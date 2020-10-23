class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :ISBN
      t.string :title
      t.text :description
      t.string :publisher
      t.string :publishDate
      t.integer :numberOfPages
      t.text :bookURL
      t.text :cover_s
      t.text :cover_m
      t.text :cover_l

      t.timestamps
    end
  end
end
