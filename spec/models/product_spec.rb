require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:valid_attributes) {
    { name: "Test Product", price: 9.99, stock_quantity: 10 }
  }

  describe "validations" do
    it "is valid with valid attributes" do
      product = Product.new(valid_attributes)
      expect(product).to be_valid
    end

    it "is not valid without a name" do
      product = Product.new(valid_attributes.except(:name))
      expect(product).to_not be_valid
    end

    it "is not valid without a price" do
      product = Product.new(valid_attributes.except(:price))
      expect(product).to_not be_valid
    end

    it "is not valid with a negative stock quantity" do
      product = Product.new(valid_attributes.merge(stock_quantity: -1))
      expect(product).to_not be_valid
    end
  end

  describe "CRUD operations" do
    it "can be created" do
      expect {
        Product.create!(valid_attributes)
      }.to change(Product, :count).by(1)
    end

    it "can be read" do
      product = Product.create!(valid_attributes)
      expect(Product.find(product.id)).to eq(product)
    end

    it "can be updated" do
      product = Product.create!(valid_attributes)
      new_name = "Updated Product"
      product.update!(name: new_name)
      expect(product.reload.name).to eq(new_name)
    end

    it "can be destroyed" do
      product = Product.create!(valid_attributes)
      expect {
        product.destroy
      }.to change(Product, :count).by(-1)
    end
  end
end