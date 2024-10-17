module ProductsHelper
  def product_in_stock?(product)
    product.stock_quantity > 0
  end
end
