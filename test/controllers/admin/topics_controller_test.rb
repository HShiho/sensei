require "test_helper"

class Admin::TopicsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_topics_show_url
    assert_response :success
  end
end
