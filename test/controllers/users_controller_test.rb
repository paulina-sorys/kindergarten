require "test_helper"
require 'mocha/minitest'

class UsersControllerTest < ActionController::TestCase
  stubbed_params = { email: "stubbed@example.com", password: "password123", password_confirmation: "password123" }

  test "should create user with valid params" do
    User.any_instance.stubs(:valid?).returns(true)
    assert_difference("User.count", 1) do
      post :create, params: { user: stubbed_params }
      assert_response :ok
    end
  end

  test "should not create user with invalid params" do
    User.any_instance.stubs(:valid?).returns(false)
    assert_difference("User.count", 0) do
      post :create, params: { user: stubbed_params }
      assert_response :bad_request
    end
  end

  test "should destroy user" do
    User.any_instance.stubs(:valid?).returns(true)
    user = User.create!(stubbed_params)

    assert_difference("User.count", -1) do
      delete :destroy, params: { id: user.id }
      assert_response :ok
    end
  end

  test "should not destroy user if not found" do
    assert_no_difference("User.count") do
      delete :destroy, params: { id: 0 } # non-existent user ID
      assert_response :not_found
    end
  end
end
