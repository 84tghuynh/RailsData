class AuthorsController < ApplicationController
  def index
    @pagy, @authors = pagy(Author.all, items: 10)
  end

  def show; end
end
