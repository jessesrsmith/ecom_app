require "test_helper"

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
    @admin = users(:admin_smith)
  end

  test "should get index" do
    log_in_as(@admin)
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "requires item in cart" do
    get :new
    assert_redirected_to products_path
    assert_equal flash[:warning], "Your cart is empty"
  end

  test "should get new" do
    item = LineItem.new
    item.build_cart
    item.product = products(:one)
    item.save!
    session[:cart_id] = item.cart.id

    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference("Order.count") do
      post :create, params: {
        stripeBillingName: "Jesse Smith",
        stripeEmail: "test@user.com",
        stripeToken: "valid_card_token"
      }
    end

    assert_redirected_to products_path
  end

  test "should show order" do
    log_in_as(@admin)
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@admin)
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    log_in_as(@admin)
    patch :update, id: @order, order: { name: @order.name, total: @order.total }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    log_in_as(@admin)
    assert_difference("Order.count", -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
