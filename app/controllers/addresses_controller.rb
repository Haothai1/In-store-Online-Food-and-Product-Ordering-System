class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_address, only: [:edit, :update, :destroy]

  def new
    @address = current_user.addresses.build
  end

  def create
    @address = current_user.addresses.build(address_params)
    if @address.save
      redirect_to profile_path, notice: 'Address added successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to profile_path, notice: 'Address updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    redirect_to profile_path, notice: 'Address removed successfully.'
  end

  private

  def set_address
    @address = current_user.addresses.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:street, :city, :state, :zip)
  end
end
