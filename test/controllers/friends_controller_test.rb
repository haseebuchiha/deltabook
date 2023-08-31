require 'test_helper'

class FriendsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get friends_create_url
    assert_response :success
  end

end
