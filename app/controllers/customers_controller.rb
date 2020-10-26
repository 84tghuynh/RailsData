class CustomersController < ApplicationController
  def index
    @pagy, @customers = pagy(Customer.all, items: 10)
  end

  def show
    @customer = Customer.find(params[:id])
  end
end
