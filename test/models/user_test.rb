require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "email present" do
  	@user = User.new
  	@user.email = "      "
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

  test "email length" do
  	@user = User.new
  	@user.email = "D"*70 + "@email.com"
  	@user.password = "password"

  	assert_not @user.valid?
  end

  test "email format" do
  	@user = User.new
  	@user.password = "password"
  	addresses = %w[test@email,com test_email.com test@email.]

  	addresses.each do |a|
  		@user.email = a
  		assert_not @user.valid?
  	end

  end

end
