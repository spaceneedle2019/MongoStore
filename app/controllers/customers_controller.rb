class CustomersController < ApplicationController

  before_action :load_customer, :except => [:index, :new, :create]

  def index
    @customers = Customer.all
  end

  def show

  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to customers_url
    else
      render :action => 'new'
    end
  end

  def edit

  end

  def update

    if @customer.update_attributes(customer_params)
      redirect_to customers_url
    else
      render :action => 'edit'
    end
  end

  def destroy

    if @customer.destroy
      redirect_to customers_url
    else
      render :action => 'index'
    end

  end

  private

  def load_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:firstname, :lastname, :age, :email)
  end

end
