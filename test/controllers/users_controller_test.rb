require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user with valid parameters" do
    assert_difference("User.count", 1) do
      post users_url, params: { user: { email_address: "test@example.com", password: "password", password_confirmation: "password" } }
    end
    assert_redirected_to new_session_path
  end

  test "should not create user with invalid email" do
    assert_no_difference("User.count") do
      post users_url, params: { user: { email_address: "email", password: "password", password_confirmation: "password" } }
    end

    assert_response :unprocessable_entity
  end

  test "should not create user if password and password confirmation don't match" do
    assert_no_difference("User.count") do
      post users_url, params: { user: { email_address: "email@email.com", password: "password", password_confirmation: "pasword" } }
    end

    assert_response :unprocessable_entity
  end
end
