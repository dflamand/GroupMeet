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

    	@g = Group.find_by(:gname => "Group")

    	post "/savelocations/" + @g.id.to_s, as: :json, params:{address:["123 fake street"], modes: ["driveMode"]}
    	assert_response :success
    	
    	@l = Location.last

    	assert_equal @l.address, "123 fake street"
    	assert_equal @l.tMode, "driveMode"

    	get "/loadlocations/" + @g.id.to_s, as: :json, params:{}
    	assert_response :success

    	@r = JSON.parse(@response.body)

    	assert_equal "123 fake street", @r[0]["address"]
    	assert_equal "driveMode", @r[0]["tMode"]

	end
end