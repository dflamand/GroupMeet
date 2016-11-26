require 'test_helper'

class UpdateProfileTestTest < ActionDispatch::IntegrationTest
  
  test "change name/email" do

  	@user = User.create(:firstName => "first", :lastName => "last", :email => "test@user.com", :password => "password", :password_confirmation => "password")

	get root_url
	assert_response :success

	post login_url, params:{ user: {email: "test@user.com", password: "password"}}

	assert_response :redirect
	assert_redirected_to root_url
	follow_redirect!

	assert_select 'a', 'Log Out'

	assert_select 'li', 'Update Profile'

	patch user_url(@user), params:{ user: {firstName: "Fchanged", lastName: "Lchanged", email: "changed@email.com"}}

	assert_response :redirect
	assert_redirected_to root_url
	follow_redirect!

	assert_select 'li[class=list-group-item]', 'Name: Fchanged Lchanged'

	delete logout_url

	assert_response :redirect
	assert_redirected_to root_url
	follow_redirect!

	post login_url, params:{ user: {email: "changed@email.com", password: "password"}}

	assert_response :redirect
	assert_redirected_to root_url
	follow_redirect!

	assert_select 'li[class=list-group-item]', 'Email: changed@email.com'

  end
end
