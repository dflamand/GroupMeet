require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  
  test "get index" do
  		get admin_index_url
  		assert_redirected_to login_url
  end

  test "get show" do
  		get admin_url(1)
  		assert_redirected_to login_url
  end

  test "get showGroup" do
  		get admin_group_url(1)
  		assert_redirected_to login_url
  end
end
