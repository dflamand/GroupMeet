require 'test_helper'

class UserLoginTestTest < ActionDispatch::IntegrationTest
  
  test "correct user login" do
  	@user = User.create(
  		:firstName => "first", 
  		:lastName => "last",
  		:email => "email@test.com",
  		:password => "password",
  		:password_confirmation => "password")

  	get root_url

  	assert_response :success

  	post login_url, params:{ user: {
  		email: "email@test.com",
  		password: "password"
  		}}

  	assert_response :redirect
  	assert_redirected_to root_url
  	follow_redirect!

  	# test if the email of the current user logged in, is the same
  	# as the user we logged in as
  	assert_select 'ul li[class=list-group-item]', 'Email: email@test.com'

  	delete logout_url
  	assert_response :redirect
  	assert_redirected_to root_url
  	follow_redirect!

  end
end
