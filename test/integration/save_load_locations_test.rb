require 'test_helper'

class SaveLoadLocationsTest < ActionDispatch::IntegrationTest
	test "save and load group locations" do
		@user = User.create(
			:email => "test@test.com", 
			:password => "password", 
			:password_confirmation => "password")

		get root_url
		assert_response :success

		post login_url, params: {user:{email: "test@test.com", password:"password"}}

		assert_response :redirect
		assert_redirected_to root_url
		follow_redirect!

		assert_select 'ul li[class=list-group-item]', 'Email: test@test.com'

		post "/groups", params: {group: {gname: "Group"}}

    	assert_response :redirect
    	assert_redirected_to root_url
    	follow_redirect!

    	
    	assert_select "a", "Leave Group"

    	post "/savelocation/1", as: :json, params:{address: "123 fake street", modes:"driveMode"}
    	assert_response :success
    	


	end
end