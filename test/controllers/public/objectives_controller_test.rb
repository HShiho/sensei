require "test_helper"

class Public::ObjectivesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_objectives_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_objectives_edit_url
    assert_response :success
  end
end
