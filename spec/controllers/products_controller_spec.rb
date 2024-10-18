require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:valid_attributes) {
    { name: "Test Product", price: 9.99, stock_quantity: 10 }
  }

  let(:invalid_attributes) {
    { name: "", price: nil, stock_quantity: -1 }
  }

  describe "GET #index" do
    it "returns a success response" do
      Product.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      product = Product.create! valid_attributes
      get :show, params: { id: product.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Product" do
        expect {
          post :create, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
      end

      it "redirects to the products list" do
        post :create, params: { product: valid_attributes }
        expect(response).to redirect_to(products_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { product: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: "Updated Product" }
      }

      it "updates the requested product" do
        product = Product.create! valid_attributes
        put :update, params: { id: product.to_param, product: new_attributes }
        product.reload
        expect(product.name).to eq("Updated Product")
      end

      it "redirects to the products list" do
        product = Product.create! valid_attributes
        put :update, params: { id: product.to_param, product: valid_attributes }
        expect(response).to redirect_to(products_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        product = Product.create! valid_attributes
        put :update, params: { id: product.to_param, product: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested product" do
      product = Product.create! valid_attributes
      expect {
        delete :destroy, params: { id: product.to_param }
      }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      product = Product.create! valid_attributes
      delete :destroy, params: { id: product.to_param }
      expect(response).to redirect_to(products_url)
    end
  end
end