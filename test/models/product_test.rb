require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products(:one)
  end

  test "should be valid" do
    assert @product.valid?
  end

  test "title should be present" do
    @product.title = "   "
    assert_not @product.valid?
  end

  test "description should be present" do
    @product.description = "   "
    assert_not @product.valid?
  end

  test "price should be present" do
    @product.price = "   "
    assert_not @product.valid?
  end

  test "price should be greater than or equal to 0.01" do
    @product.price = 0.00
    assert_not @product.valid?
    assert_equal ["must be greater than or equal to 0.01"],
                 @product.errors[:price]
  end

  test "price must be positive" do
    @product.price = -1
    assert_not @product.valid?
    assert_equal ["must be greater than or equal to 0.01"],
                 @product.errors[:price]
    @product.price = 1
    assert @product.valid?
  end

  test "title should not be too long" do
    @product.title = "a" * 51
    assert_not @product.valid?
  end

  test "title should be unique" do
    duplicate_product = Product.new(title: products(:one).title,
                                    description: "yyy",
                                    price:  1)
    duplicate_product.save
    assert_not duplicate_product.valid?
    assert_equal ["has already been taken"], duplicate_product.errors[:title]
  end
end
