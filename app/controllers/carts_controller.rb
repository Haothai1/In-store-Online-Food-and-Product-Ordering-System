class CartsController < ApplicationController
  def show
    @cart = current_cart
    @cart_items = @cart.cart_items.includes(:product)
  end
 
  # add item to cart
  def add_item
    product = Product.find(params[:product_id])
    if product.in_stock?
      @cart = current_cart
      @cart.add_product(product)
      redirect_back(fallback_location: root_path, notice: 'Item added to cart.')
    else
      redirect_back(fallback_location: root_path, alert: 'Sorry, this item is out of stock.')
    end
  end

  # remove item from cart
  def remove_item
    @cart = current_cart
    item = @cart.cart_items.find_by(id: params[:id])
    if item
      item.destroy
      @cart.reload  # Make sure cart is up-to-date
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('cart-count', partial: 'layouts/cart_count', locals: { cart: @cart }),
            turbo_stream.replace('cart-items', partial: 'carts/cart_items', locals: { cart_items: @cart.cart_items.includes(:product) })
          ]
        end
        format.html { redirect_to cart_path, notice: 'Item removed from cart.' }
      end
    else
      respond_to do |format|
        format.turbo_stream { head :not_found }
        format.html { redirect_to cart_path, alert: 'Item not found in cart.' }
      end
    end
  end

  def checkout
    @cart = current_cart

    ActiveRecord::Base.transaction do
      # Create a new order
      order = current_user.orders.new(
        status: 'completed',
        total_price: @cart.total_price,
        order_type: 'online'
      )

      @cart.cart_items.each do |cart_item|
        product = cart_item.product
        if product.stock_quantity >= cart_item.quantity
          new_quantity = product.stock_quantity - cart_item.quantity
          product.update!(stock_quantity: new_quantity)
          
          # Create an order item for each cart item
          order.order_items.new(
            product_id: product.id,
            quantity: cart_item.quantity,
            price: product.price
          )
        else
          raise ActiveRecord::Rollback, "Not enough stock for #{product.name}"
        end
      end

      # Save the order
      order.save!

      @cart.update!(status: 'completed')
      session[:cart_id] = nil
    end

    redirect_to order_history_path, notice: 'Thank you for your purchase!'
  rescue ActiveRecord::Rollback => e
    redirect_to cart_path, alert: e.message
  end

  private
  # show cart count in the header
  def current_cart
    Cart.find_by(id: session[:cart_id]) || Cart.create.tap { |cart| session[:cart_id] = cart.id }
  end
  
  def update_cart_count(replace_items: true)
    @cart.reload
    # show cart count in the header
    respond_to do |format|
      format.turbo_stream do
        if @cart.errors.empty?
          streams = [turbo_stream.replace('cart-count', partial: 'layouts/cart_count', locals: { cart: @cart })]
          streams << turbo_stream.replace('cart-items', partial: 'carts/cart_items', locals: { cart_items: @cart.cart_items.includes(:product) }) if replace_items
          render turbo_stream: streams
        else
          render turbo_stream: turbo_stream.replace('cart-errors', partial: 'shared/errors', locals: { errors: @cart.errors })
        end
      end
      format.html do
        if @cart.errors.any?
          flash[:alert] = @cart.errors.full_messages.to_sentence
        else
          flash[:notice] = 'Cart updated successfully.'
        end
        redirect_back(fallback_location: cart_path)
      end
    end
  end
end
