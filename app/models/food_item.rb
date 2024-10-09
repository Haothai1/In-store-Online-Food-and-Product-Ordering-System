class FoodItem < ApplicationRecord
  has_many :order_items, as: :item
  validates :name, :price, presence: true
end
