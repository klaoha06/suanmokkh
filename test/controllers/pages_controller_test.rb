require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get teachings" do
    get :teachings
    assert_response :success
  end

end
