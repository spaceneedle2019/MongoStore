class Address
  include Mongoid::Document
  include Mongoid::Timestamps

  field :street, type: String
  field :zip, type: String
  field :city, type: String
  field :primary, type: Boolean, default: false

  validates_presence_of :street, :zip, :city
  validates :zip, :numericality => true, :length => {:is => 5}

  embedded_in :customer

  after_save :reset_primary

  def city_with_zip
    "#{self.zip} #{self.city}"
  end

  private

  def reset_primary
    if self.primary
      self._parent.addresses.each do |address|
        address.set(:primary => false) if address.id != self.id
      end
    end
  end

end
