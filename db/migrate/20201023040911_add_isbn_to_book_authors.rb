class AddIsbnToBookAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :book_authors, :ISBN, :string
  end
end
