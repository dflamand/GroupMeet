require 'test_helper'

class GroupDeleteTest < ActionDispatch::IntegrationTest
  fixtures :groups
  fixtures :users

  test "group delete" do

    post "/users", params: {user: {firstName: "asd", lastName: "asd", email: "asd@asd.com", password: "test", password_confirmation: "test"}}
    assert_response :redirect
    assert_redirected_to root_url
    follow_redirect!

    post "/groups", params: {group: {gname: "Test1"}}
    assert_response :redirect
    assert_redirected_to root_url
    follow_redirect!

    @g = Group.find_by(:gname => "Test1")

    delete "/groups/" + @g.id.to_s
    assert_response :redirect
    assert_redirected_to root_url
    follow_redirect!

    @g = Group.find_by(:gname => "Test1")

    assert_not @g

  end

end
