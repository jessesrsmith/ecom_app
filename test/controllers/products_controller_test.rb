require "test_helper"

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
    @update = {
      title: "Product Test",
      description: "Another nice thing to buy.",
      price: 4.33
    }
    @admin = users(:admin_smith)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    log_in_as(@admin)
    get :new
    assert_response :success
  end

  test "should create product" do
    log_in_as(@admin)
    assert_difference("Product.count") do
      post :create, product: @update
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@admin)
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    log_in_as(@admin)
    patch :update, id: @product, product: @update
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    log_in_as(@admin)
    assert_difference("Product.count", -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
