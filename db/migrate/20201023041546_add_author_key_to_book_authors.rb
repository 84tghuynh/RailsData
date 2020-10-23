class AddAuthorKeyToBookAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :book_authors, :authorKey, :string
  end
end
