class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :destroy]

  def show
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to products_url, warning: "Your cart is empty"
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params[:cart]
    end
end
