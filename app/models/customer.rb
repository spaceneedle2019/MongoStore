class Customer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :firstname, type: String
  field :lastname, type: String
  field :age, type: Integer
  field :email, type: String

  embeds_many :addresses
  embeds_one :payment

  validates_presence_of :firstname, :lastname
  validates :age, :numericality => true, :length => {:maximum => 3}, :allow_blank => true
  validates :email, :presence => true, :format => { :with => /\A([a-z0-9_\+\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})\z/i }

  before_save :remove_age_if_blank

  def full_name
    "#{self.firstname} #{self.lastname}"
  end

  private

  def remove_age_if_blank
    self.unset(:age) if self.age.blank?
  end

end
