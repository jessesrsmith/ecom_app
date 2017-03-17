class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info

  include SessionsHelper

  etag { set_cart.item_quantity }

  def not_found
    fail ActiveRecord::RecordNotFound, "Not Found"
  end

  def admin_user
    @user = current_user
    redirect_to(root_url) unless logged_in? && @user.admin?
  end

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
    return @cart
  end
end
