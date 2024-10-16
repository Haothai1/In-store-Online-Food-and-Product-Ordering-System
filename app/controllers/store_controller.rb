class StoreController < ApplicationController
  def index
    @store_items = Product.where(category: 'Store')
    if params[:query].present?
      @store_items = @store_items.where("name ILIKE ?", "%#{params[:query]}%")
    end
  end
end
