require "test_helper"

class UsersDestroyTestTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:admin_smith)
    @user  = users(:user_a)
  end

  test "successful user deletion when logged in as admin" do
    log_in_as @admin
    assert_difference "User.count", -1 do
      delete user_path(@user)
    end
  end
end
