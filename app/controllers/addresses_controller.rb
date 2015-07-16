class AddressesController < ApplicationController

  before_action :load_customer
  before_action :load_address, :except => [:index, :new, :create]

  def index
    @addresses = @customer.addresses.all
  end

  def new
    @address = @customer.addresses.new
  end

  def create
    @address = @customer.addresses.new(address_params)

    if @address.save
      redirect_to customer_addresses_url
    else
      render :action => 'new'
    end
  end

  def edit

  end

  def update

    if @address.update_attributes(address_params)
      redirect_to customer_addresses_url
    else
      render :action => 'edit'
    end
  end

  def destroy

    if @address.destroy
      redirect_to customer_addresses_url
    else
      render :action => 'index'
    end
  end

  private

  def load_customer
    @customer = Customer.find(params[:customer_id])
  end

  def load_address
    @address = @customer.addresses.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:street, :zip, :city, :primary)
  end

end
