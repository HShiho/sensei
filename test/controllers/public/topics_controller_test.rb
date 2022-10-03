require "test_helper"

class Public::TopicsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_topics_new_url
    assert_response :success
  end

  test "should get index" do
    get public_topics_index_url
    assert_response :success
  end

  test "should get show" do
    get public_topics_show_url
    assert_response :success
  end
end
