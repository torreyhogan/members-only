require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup 
  	@user = User.new(username: "Example User", email: "example@user.com", 
  										password: "foobar", password_confirmation: "foobar")
  end

  test "email should be unique" do
  	duplicate_user = @user.dup 
  	@user.save
  	assert_not duplicate_user.valid?
  end

  test "valid email should be accepted" do 
  	@user.email = "billy@gmail.com"
  	assert @user.valid?
  end

  test "invalid email should be rejected" do
  	@user.email = "billy@fren"
  	assert_not @user.valid?
  end

  test "email should not be case sensitive" do 
  	CASE_EMAIL = "ExAmpLe@GmaIl.Com"
  	@user.email = CASE_EMAIL
  	@user.save
  	assert_equal @user.reload.email, CASE_EMAIL.downcase
  end

  test "password must be present" do 
  	@user.password = @user.password_confirmation = " " * 6
  	assert_not @user.valid?
  end

  test "password should have minimum length" do 
  	@user.password = @user.password_confirmation = "a" * 5
  	assert_not @user.valid?
  end

end
