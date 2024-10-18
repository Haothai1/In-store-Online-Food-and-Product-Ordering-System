class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def history
    @orders = current_user.orders.order(created_at: :desc)
  end
end
