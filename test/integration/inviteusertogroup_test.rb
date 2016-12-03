require 'test_helper'

class InviteusertogroupTest < ActionDispatch::IntegrationTest
  test "invite user" do
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
    assert @group

    testdas = [@user2.id, @user3.id]
    post invited_url, as: :json, params: {invite: {user_email: "test2@test2.com", group_id: @group.id}}
    assert_response :success
    assert @user2.invites.present?

  end


end
