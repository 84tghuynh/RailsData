class HomeController < ApplicationController
  def index
    @books = Book.includes(:category)
                 .limit(10)

    @authors = Author.all
                     .limit(10)
    @customers = Customer.all
                         .limit(10)

    @categories = Category.all
  end

  def about_data; end
end
