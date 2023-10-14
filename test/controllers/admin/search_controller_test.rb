require "test_helper"

class Admin::SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get customers_search" do
    get admin_search_customers_search_url
    assert_response :success
  end

  test "should get posts_search" do
    get admin_search_posts_search_url
    assert_response :success
  end
end
