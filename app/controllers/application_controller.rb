class ApplicationController < ActionController::Base
  # allow user to change their name
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_cart
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
    @current_cart ||= Cart.find_by(id: session[:cart_id])
    if @current_cart.nil?
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
    end
    @current_cart
  end

  def set_current_cart
    if current_cart.nil?
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
    end
  end
end
