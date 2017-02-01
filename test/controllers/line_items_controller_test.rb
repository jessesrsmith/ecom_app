require "test_helper"

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
  end

  test "should create line_item" do
    assert_difference("LineItem.count") do
      post :create, product_id: products(:one).id
    end

    assert_redirected_to products_path
  end

  test "should create line_item via Ajax" do
    assert_difference("LineItem.count") do
      xhr :post, :create, product_id: products(:one).id
    end

    assert_response :success
  end

  test "should update line_item" do
    patch :update, id: @line_item, line_item: { product_id: @line_item.product_id }
    assert_redirected_to assigns(:cart)
  end

  test "should destroy line_item" do
    assert_difference("LineItem.count", -1) do
      delete :destroy, id: @line_item
    end

    if LineItem.count.zero?
      assert_redirected_to assigns(:cart)
    else
      assert_redirected_to products_url
    end
  end
end
