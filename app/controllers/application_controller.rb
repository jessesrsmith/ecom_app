class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info
  include SessionsHelper
  include CurrentCart
  etag { set_cart.item_quantity }

  def not_found
    fail ActiveRecord::RecordNotFound, "Not Found"
  end

end
