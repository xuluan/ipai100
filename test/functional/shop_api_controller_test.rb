require 'test_helper'

class ShopApiControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

end
