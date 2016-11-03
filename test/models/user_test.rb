require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "email present" do
  	@user = User.new
  	@user.email = "     "
  	@user.password = "password"

  	assert_not @user.valid?
  end

  test "password present" do
  	@user = User.new
  	@user.email = "email@test.ca"
  	@user.password = "   "

  	assert_not @user.valid?	
  end

  test "duplicate email" do
  	@first = User.new
  	@first.email = "email@test.com"
  	@first.password = "password"
  	@first.save

  	@second = User.new
  	@second.email = "email@test.com"
  	@first.password = "password"

  	assert_not @second.valid?
  end
end
