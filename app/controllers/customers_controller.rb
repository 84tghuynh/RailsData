class CustomersController < ApplicationController
  def index
    def index
      @pagy, @customers = pagy(Customer.all, items: 10)
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end
end
