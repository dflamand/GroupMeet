require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  
  test "is connected to group" do
  	@l = Location.new

  	assert_not @l.valid?
  end
end
