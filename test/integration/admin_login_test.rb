require 'test_helper'

class AdminLoginTest < ActionDispatch::IntegrationTest

	test "admin login/logout" do
		get login_url

		assert_response :success

		post login_path, params: { user:{ email: "admin@group.com", password: "password"}}

		assert_response :success

		assert_select 'table'

		get logout_url

		assert_redirected_to root_url

	end
end
