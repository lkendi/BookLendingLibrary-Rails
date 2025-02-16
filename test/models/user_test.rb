require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email_address: "  USER@Example.COM  ", password: "password", role: "user")
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "email address should be present" do
    @user.email_address = nil
    assert_not @user.valid?
    assert_includes @user.errors[:email_address], "is required"
  end

  test "email address should be unique" do
    @user.save!
    duplicate_user = @user.dup
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:email_address], "is already registered"
  end

  test "email address should be normalized before saving" do
    @user.save!
    assert_equal "user@example.com", @user.email_address
  end

  test "should be invalid with improperly formatted email address" do
    @user.email_address = "invalid_email"
    assert_not @user.valid?
    assert_includes @user.errors[:email_address], "is invalid"
  end

  test "should authenticate with correct password" do
    @user.save!
    assert @user.authenticate("password")
  end

  test "should not authenticate with incorrect password" do
    @user.save!
    assert_not @user.authenticate("wrongpassword")
  end

  test "authenticated? returns false when Current.session is nil" do
    Current.session = nil
    assert_not @user.authenticated?
  end

  test "authenticated? returns true when Current.session is present" do
    dummy_session = Object.new
    Current.session = dummy_session
    assert @user.authenticated?
  ensure
    Current.session = nil
  end
end
