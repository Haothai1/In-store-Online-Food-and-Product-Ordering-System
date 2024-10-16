class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items

  scope :open, -> { where(status: 'open') }

  def add_product(product)
    current_item = cart_items.find_by(product_id: product.id)
    if current_item
      current_item.increment!(:quantity)
    else
      cart_items.create(product_id: product.id, quantity: 1)
    end
  end

  def total_price
    cart_items.sum { |item| item.product.price * item.quantity }
  end
end
