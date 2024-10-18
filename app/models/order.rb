class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  enum status: { pending: 'pending', completed: 'completed', cancelled: 'cancelled' }

  validates :status, :total_price, :order_type, presence: true

  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def total_items
    order_items.sum(:quantity)
  end

  scope :recent, -> { order(created_at: :desc) }

  def total
    total_price
  end
end
