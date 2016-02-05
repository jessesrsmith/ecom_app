require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin_smith)
    @user = users(:user_a)
  end

  test "index as admin including pagination" do
    log_in_as(@admin)
    get users_path
    assert_template "users/index"
    assert_select "div.pagination"
    User.paginate(page: 1).order(:name).each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end
end