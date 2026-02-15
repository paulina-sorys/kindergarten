require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @valid_user_params = {
      email: "user@example.com",
      password: "securepassword",
      password_confirmation: "securepassword"
    }
  end

  test "should create user with valid attributes" do
    user = User.new(@valid_user_params)
    assert user.save, "Failed to save valid user"
  end

  test "should require email" do
    user = User.new(@valid_user_params.merge(email: ""))
    assert_not user.valid?, "User is valid without email"
    assert_includes user.errors[:email], "can't be blank"
  end

  test "should require unique email" do
    User.create!(@valid_user_params)
    duplicate_user = User.new(@valid_user_params)
    assert_not duplicate_user.valid?, "User is valid with duplicate email"
    assert_includes duplicate_user.errors[:email], "has already been taken"
  end

  test "should require password" do
    user = User.new(email: "new@example.com")
    assert_not user.valid?, "User is valid without password"
    assert_includes user.errors[:password], "can't be blank"
  end

  test "should require matching password confirmation" do
    user = User.new(email: "new@example.com", password: "pass1", password_confirmation: "pass2")
    assert_not user.valid?, "User is valid with non-matching password confirmation"
    assert_includes user.errors[:password_confirmation], "doesn't match Password"
  end

  test "should not allow empty strings for required fields" do
    user = User.new(email: "new@example.com", password: "", password_confirmation: "")
    assert_not user.valid?, "User is valid with empty strings for password and password confirmation"

    assert_includes user.errors[:password], "can't be blank"
    assert_includes user.errors[:password_confirmation], "can't be blank"
  end

  test "should hash password" do
    user = User.create!(@valid_user_params)
    assert_not_equal @valid_user_params[:password], user.password_digest, "Password is not hashed"
    assert user.authenticate(@valid_user_params[:password]), "Password authentication failed"
  end

  test "should reject invalid email format" do
    user = User.new(email: "invalid_email", password: "password", password_confirmation: "password")
    assert_not user.valid?, "Email has invalid format"
    assert_includes user.errors[:email], "is invalid"
  end

  test "should downcase email before save" do
    user = User.create!(email: "USER@EXAMPLE.COM", password: "password", password_confirmation: "password")
    assert_equal "user@example.com", user.email
  end
end
