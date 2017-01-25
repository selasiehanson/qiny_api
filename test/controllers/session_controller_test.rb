require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get session_register_url
    assert_response :success
  end

end
