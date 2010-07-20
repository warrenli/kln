class Order < ActiveRecord::Base
  attr_accessible :customer, :currency, :price, :delivered, :expiration_date

  validates_presence_of :customer, :currency, :price, :expiration_date
  validates_numericality_of :price, :greater_than_or_equal_to => 0.00

  scope :active, where(:deleted => false)

  def destroy
    delete!
  end

  private

  def delete!
    unless self.deleted
      self.deleted = true
      save!
    end
  end
end

