require 'rails_helper'

RSpec.describe "Carts", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/carts/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /add_item" do
    it "returns http success" do
      get "/carts/add_item"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /remove_item" do
    it "returns http success" do
      get "/carts/remove_item"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /checkout" do
    it "returns http success" do
      get "/carts/checkout"
      expect(response).to have_http_status(:success)
    end
  end

end
