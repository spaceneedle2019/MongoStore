class Payment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :card_holder, type: String
  field :method, type: Integer

  field :iban, type: String
  field :bic, type: String

  field :number, type: String
  field :expiration_date, type: Date
  field :cvc, type: String

  METHODS = [
      BANK_ACCOUNT = 1,
      CREDIT_CARD = 2
  ]

  embedded_in :customer

  validates :card_holder, :presence => true

  with_options if: :is_debit? do |bank_account|
    bank_account.validates :iban, :presence => true
    bank_account.validates :bic, :presence => true
  end

  with_options unless: :is_debit? do |credit_card|
    credit_card.validates :number, :presence => true
    credit_card.validates :cvc, :presence => true, :numericality => true, :length => {:is => 3}
    credit_card.validates :expiration_date, :presence => true
  end

  before_save :remove_unneeded_attributes

  def is_debit?
    self.method == Payment::BANK_ACCOUNT
  end

  private

  def remove_unneeded_attributes
    if self.is_debit?
      self.unset(:number)
      self.unset(:cvc)
      self.unset(:expiration_date)
    else
      self.unset(:iban)
      self.unset(:bic)
    end
  end


end
