require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

	test "logout" do
		delete logout_url
		assert_redirected_to root_url
	end

end
