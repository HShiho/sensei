require "test_helper"

class Public::FollowsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_follows_show_url
    assert_response :success
  end
end
