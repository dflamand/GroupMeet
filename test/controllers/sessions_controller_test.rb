require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
	test "login" do
		get login_url
		assert_response :success
	end

	test "logout" do
		get logout_url
		assert_redirected_to root_url
	end

end
