require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest

	test "get root" do 
		get root_url
		assert_response :success
	end
end
