require "test_helper"

class UsersControllerTest < ActionController::TestCase
  test "rejects POST request without CSRF token" do
    @request.env["HTTP_X_CSRF_TOKEN"] = nil

    assert_raises(ActionController::InvalidAuthenticityToken) do
      post :create, params: { some: "data" }
    end
  end

  test "should create user with valid params" do
    assert_difference("User.count", 1) do
      post :create, params: { user: { email: "newuser@example.com", password: "password123", password_confirmation: "password123" } }
    end

    assert_response http_status_code(:ok)
  end

  test "should not create user with invalid params" do
    assert_no_difference("User.count") do
      post :create, params: { user: { email: "", password: "short", password_confirmation: "mismatch" } }
    end

    assert_response http_status_code(:bad_request)
  end

  test "should destroy user" do
    user = users(:one)

    assert_difference("User.count", -1) do
      delete :destroy, params: { id: user.id }
    end

    assert_response http_status_code(:ok)
  end

  test "should not destroy user if not found" do
    assert_no_difference("User.count") do
      delete :destroy, params: { id: 0 } # non-existent user ID
    end

    assert_response http_status_code(:not_found)
  end
end
