class Product < ApplicationRecord
  has_many :order_items, as: :item
  validates :name, :price, :stock_quantity, presence: true
end
