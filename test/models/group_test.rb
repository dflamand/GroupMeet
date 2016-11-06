require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  test "group name" do
    @group = Group.new
    @group.gname = "  "
    
    assert_not @group.valid?
  end
  
  test "name length" do
    @group = Group.new
    @group.gname = "s"*31
    
    assert_not @group.valid?
  end
end
