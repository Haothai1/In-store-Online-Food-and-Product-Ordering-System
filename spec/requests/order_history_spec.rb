require 'rails_helper'

RSpec.describe "OrderHistories", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/order_history/index"
      expect(response).to have_http_status(:success)
    end
  end

end
