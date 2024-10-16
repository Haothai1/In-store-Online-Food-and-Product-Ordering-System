class MenuController < ApplicationController
  def index
    @menu_items = Product.where(category: 'Food')
    if params[:query].present?
      @menu_items = @menu_items.where("name ILIKE ?", "%#{params[:query]}%")
    end
  end
end
