require 'test_helper'

class AdminLoginTest < ActionDispatch::IntegrationTest

	test "admin login/logout" do
		load "#{Rails.root}/db/seeds.rb"

		get root_url

		assert_response :success

		post login_path, params: { user:{ email: "admin@meet.com", password: "password"}}

		assert_response :redirect
		assert_redirected_to admin_index_url
		follow_redirect!

		assert_select 'h1', 'Admin: admin@meet.com'

		assert_select 'table'

		delete logout_url

		assert_response :redirect
		assert_redirected_to root_url
	end
end
