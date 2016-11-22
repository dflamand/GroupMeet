require 'test_helper'

class UserRegistrationTestTest < ActionDispatch::IntegrationTest
  

  test "sign-up new user" do
  	# this test first posts to create a new user
  	# checks if after creation it was redirected to the proper page
  	# logs out the user
  	# then tries to log in the user that was just created

  	get root_url
  	assert_response :success

  	post users_url, params:{ user:{
  		firstName: "NEW", 
  		lastName: "USER", 
  		email: "new@user.com", 
  		password: "password", 
  		password_confirmation: "password"}}

  	assert_response :redirect
  	assert_redirected_to root_url
  	follow_redirect!

  	# The log out link only appears if there is a user signed in
  	# so checking for it will confirm there is a logged in user
  	assert_select 'a', 'Log Out'

  	delete logout_url
  	assert_response :redirect
  	assert_redirected_to root_url
  	follow_redirect!

  	# log in only appears if no user is signed in
  	assert_select 'a', 'Login'

  	post login_url, params:{ user:{
  		firstName: "NEW", 
  		lastName: "USER", 
  		email: "new@user.com", 
  		password: "password", 
  		password_confirmation: "password"}}

  	assert_response :redirect
  	assert_redirected_to root_url
  	follow_redirect!

  	assert_select 'a', 'Log Out'

  end
end
