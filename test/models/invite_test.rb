require 'test_helper'

class InviteTest < ActiveSupport::TestCase
  
  test "has user_id" do
  	@I = Invite.new
  	@I.group_id = 12
  	@I.gname = "name"

  	assert_not @I.valid?

  end

  test "has group_id" do
  	@I = Invite.new
  	@I.user_id = 12
  	@I.gname = "name"

  	assert_not @I.valid?
  end

  test "has gname" do
  	@I = Invite.new
  	@I.group_id = 12
  	@I.user_id = 12

  	assert_not @I.valid?

  end
end
