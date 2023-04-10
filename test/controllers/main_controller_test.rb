require "test_helper"

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get main_login_url
    assert_response :success
  end

  test "should get register" do
    get main_register_url
    assert_response :success
  end
end
