class Product < ApplicationRecord
  has_many :order_items, as: :item
  # cart items
  has_many :cart_items
  has_many :carts, through: :cart_items
  # order items
  validates :name, :price, presence: true
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
  
  # Set a default value:
  after_initialize :set_default_stock_quantity, if: :new_record?

  def in_stock?
    stock_quantity > 0
  end

  private
  
  def set_default_stock_quantity
    self.stock_quantity ||= 0
  end
end
