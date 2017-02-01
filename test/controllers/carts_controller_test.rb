require "test_helper"

class CartsControllerTest < ActionController::TestCase
  setup do
    @cart = carts(:one)
  end

  test "should show cart" do
    get :show, id: @cart
    assert_response :success
  end

  test "should destroy cart" do
    assert_difference("Cart.count", -1) do
      session[:cart_id] = @cart.id
      delete :destroy, id: @cart
    end

    assert_redirected_to products_path
  end

  test "should not allow access to invalid cart" do
    get :show, id: "123"
    assert_not flash.empty?
    assert_redirected_to products_url
  end
end
