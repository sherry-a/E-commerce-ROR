require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get show_users" do
    get admin_show_users_url
    assert_response :success
  end

  test "should get show_orders" do
    get admin_show_orders_url
    assert_response :success
  end
end
