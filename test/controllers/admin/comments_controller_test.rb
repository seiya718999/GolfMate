require "test_helper"

class Admin::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_comments_edit_url
    assert_response :success
  end
end
