require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid with valid attributes" do
    product = Product.new(name: "Test Product", price: 9.99, stock_quantity: 10)
    expect(product).to be_valid
  end

  it "is invalid without a name" do
    product = Product.new(price: 9.99, stock_quantity: 10)
    expect(product).not_to be_valid
  end
end
