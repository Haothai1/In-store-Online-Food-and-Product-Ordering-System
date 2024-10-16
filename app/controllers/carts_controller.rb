class CartsController < ApplicationController
  def show
    @cart = current_cart
  end

  def add_item
    product = Product.find(params[:product_id])
    @cart = current_cart
    @cart.add_product(product)
    redirect_back(fallback_location: root_path, notice: 'Item added to cart.')
  end

  def remove_item
    @cart = current_cart
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path, notice: 'Item removed from cart.'
  end

  def checkout
    @cart = current_cart
    @cart.update(status: 'completed')
    session[:cart_id] = nil
    redirect_to root_path, notice: 'Thank you for your purchase!'
  rescue => e
    redirect_to cart_path, alert: "Checkout failed: #{e.message}"
  end

  private

  def current_cart
  Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create(status: 'open')
    session[:cart_id] = cart.id
    cart
  end
end
