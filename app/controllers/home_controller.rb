class HomeController < ApplicationController
  def index
    @books = Book.includes(:category)
                 .limit(10)

    @authors = Author.all
                     .litmit(10)
  end

  def about_data; end
end
