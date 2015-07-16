class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :number, type: Integer, default: 1
  field :name, type: String
  field :description, type: String
  field :price, type: Float

  validates :name, :presence => true
  validates :price, :presence => true, :numericality => true

  before_save :remove_description_if_blank
  before_create :autoincrement_number

  private

  def remove_description_if_blank
    self.unset(:description) if self.description.blank?
  end

  def autoincrement_number
    product = Product.last
    self.number = product.number + 1 unless product.nil?
  end

end
