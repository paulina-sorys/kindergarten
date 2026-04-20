require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @valid_user_params = {
      email: "user@example.com",
      password: "securePassword1",
      password_confirmation: "securePassword1"
    }
    @user = User.new(@valid_user_params)
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
    assert_includes @user.errors[:email], "can't be blank"
  end

  test "email should be unique (case insensitive)" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:email], "has already been taken"
  end

  test "email should have valid format" do
    invalid_emails = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email.inspect} should be invalid"
      assert_includes @user.errors[:email], "is invalid"
    end

    valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      @user.password = "Password1"
      @user.password_confirmation = "Password1"
      assert @user.valid?, "#{valid_email.inspect} should be valid"
    end
  end

   test "password should be present" do
    @user.password = @user.password_confirmation = " " * 8
    assert_not @user.valid?
    assert_includes @user.errors[:password], "can't be blank"
  end

   test "password should have minimum length of 8" do
    @user.password = @user.password_confirmation = "Pass1"
    assert_not @user.valid?
    assert_includes @user.errors[:password], "is too short (minimum is 8 characters)"
  end

  test "password should include uppercase, lowercase and digit" do
    invalid_passwords = %w[password PASSWORD123 password123 PASSWORD]
    invalid_passwords.each do |pwd|
      @user.password = @user.password_confirmation = pwd
      assert_not @user.valid?, "#{pwd.inspect} should be invalid"
      assert_includes @user.errors[:password], "must include uppercase, lowercase and digit"
    end

    valid_password = "Password1"
    @user.password = @user.password_confirmation = valid_password
    assert @user.valid?, "#{valid_password.inspect} should be valid"
  end

  test "password confirmation should be present" do
    @user.password_confirmation = ""
    assert_not @user.valid?
    assert_includes @user.errors[:password_confirmation], "can't be blank"
  end

  test "should hash password" do
    assert @user.save, "User should be saved successfully"

    assert_not_nil @user.password_digest, "password_digest should be set"
    assert_not_equal "Password1", @user.password_digest, "password_digest should not be equal to plain password"
  end

  test "email should be saved as lowercase" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      @user.email = mixed_case_email
      @user.save
      assert_equal mixed_case_email.downcase, @user.reload.email
  end
end
