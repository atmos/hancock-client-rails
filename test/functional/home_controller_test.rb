require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "the landing page" do
    get :index
    assert_response :redirect
  end
end
