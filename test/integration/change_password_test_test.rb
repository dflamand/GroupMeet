require 'test_helper'

class ChangePasswordTestTest < ActionDispatch::IntegrationTest
  
  test "change password" do

  	@user = User.create(:email => "test@user.com", :password => "password", :password_confirmation => "password")

	get root_url
	assert_response :success

	post login_url, params:{ user: {email: "test@user.com", password: "password"}}

	assert_response :redirect
	assert_redirected_to root_url
	follow_redirect!

	assert_select 'ul li[class=list-group-item]', 'Email: test@user.com'

	assert_select 'li', 'Change Password'

	patch changepassword_url, params:{user:{ password: "NOTpassword", password_confirmation: "NOTpassword"}}

	assert_response :redirect
	assert_redirected_to root_url
	follow_redirect!

	delete logout_url

	assert_response :redirect
	assert_redirected_to root_url
	follow_redirect!

  	post login_url, params:{ user: {email: "test@user.com", password: "NOTpassword"}}

 	assert_response :redirect
	assert_redirected_to root_url
	follow_redirect!

	assert_select 'ul li[class=list-group-item]', 'Email: test@user.com'

  end
end
