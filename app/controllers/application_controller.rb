class ApplicationController < ActionController::Base
  # allow user to change their name
  before_action :configure_permitted_parameters, if: :devise_controller?
  # cart
  helper_method :current_cart

  protected
  # devise to allow user to change their name
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private
  # cart to allow user to add items to their cart
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
