class BooksController < ApplicationController
  def index
    @pagy, @books = pagy(Book.all, items: 10)
  end

  def show
    @book = Book.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    category_search = params[:category].to_s

    @books = if category_search == "0"
               Book.where("title LIKE ?", wildcard_search)
             else
               Book.joins(:category)
                   .where("title LIKE ?", wildcard_search)
                   .where("category_id = ?", category_search)
             end
  end
end
