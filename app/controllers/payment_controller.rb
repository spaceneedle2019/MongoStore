class PaymentController < ApplicationController
  before_action :load_customer, :load_payment

  def edit

  end

  def update

    if @payment.update_attributes(payment_params)
      redirect_to customers_url
    else
      render :action => 'edit'
    end
  end

  def destroy

    if @payment.destroy
      redirect_to customers_url
    else
      render :action => 'index'
    end
  end

  private

  def load_customer
    @customer = Customer.find(params[:customer_id])
  end

  def load_payment
    @payment = @customer.payment

    if @payment.nil?
      @payment = Payment.new(:customer => @customer)
    end
  end

  def payment_params
    params.require(:payment)
        .permit(
            :card_holder,
            :method,
            :iban,
            :bic,
            :number,
            :expiration_date,
            :cvc
        ).merge(:expiration_date => build_expiration_date)
  end

  def build_expiration_date
    "01-#{params[:date][:month]}-#{params[:date][:year]}".to_date
  end

end
