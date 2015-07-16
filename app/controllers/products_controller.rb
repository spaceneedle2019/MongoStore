class ProductsController < ApplicationController
  before_action :load_product, :except => [:index, :new, :create]

  def index
    @products = Product.all
  end

  def show

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_url
    else
      render :action => 'new'
    end
  end

  def edit

  end

  def update

    if @product.update_attributes(product_params)
      redirect_to products_url
    else
      render :action => 'edit'
    end
  end

  def destroy

    if @product.destroy
      redirect_to products_url
    else
      render :action => 'index'
    end

  end

  private

  def load_product
    @product = Product.find(params[:id])
  end

  def corrected_price
    params[:product][:price].gsub(",", ".")
  end

  def product_params
    params.require(:product).permit(:number, :name, :description, :price).merge(:price => corrected_price)
  end
end
