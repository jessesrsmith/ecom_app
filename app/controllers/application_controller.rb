class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info

  include SessionsHelper
  include CurrentCart

  etag { set_cart.item_quantity }

  def not_found
    fail ActiveRecord::RecordNotFound, "Not Found"
  end

  def admin_user
      @user = current_user
      redirect_to(root_url) unless logged_in? && @user.admin?
  end
end
