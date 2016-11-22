require 'test_helper'

class AddusertogroupTest < ActionDispatch::IntegrationTest
  test "add user" do
    @user = User.create(:firstName => "hi", :lastName => "last", :email => "test@test.com", :password => "das", :password_confirmation => "das")
    @user2 = User.create(:firstName => "hi", :lastName => "last", :email => "test2@test2.com", :password => "das", :password_confirmation => "das")
    @user3 = User.create(:firstName => "hi", :lastName => "last", :email => "test3@test3.com", :password => "das", :password_confirmation => "das")

    post login_url, params: {user: {email: "test@test.com", password: "das"}}
    assert_response :redirect
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a", "Log Out"

    post groups_url params: {group: {gname: "Das Salad", groupowner: @user.id}}
    assert_response :redirect
    assert_redirected_to root_url
    follow_redirect!

    @group = Group.find_by(:gname => "Das Salad")

    testdas = [@user2.id, @user3.id]
    post adduser_url, as: :json, params: {addusers: testdas, groupid: @group.id}
    assert_response :success

  end


end
