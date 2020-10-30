class AuthorsController < ApplicationController
  def index
    @pagy, @authors = pagy(Author.all, items: 10)
  end

  def show
    @author = Author.find(params[:id])
  end
end
