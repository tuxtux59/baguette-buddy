require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "login page is accessible" do
    get login_path

    assert_response :success
  end

  test "can connect with valid credentials" do
    User.create!(username: "user2", email: "user2@example.com", password: "password")
    post login_path, params: { user: { email_or_username: "user2@example.com", password: "password" } }

    assert_redirected_to receipes_path
    assert flash[:notice].to_s.include?("signed in")
  end
  
  test "can connect with valid username" do
    User.create!(username: "user5", email: "user5@example.com", password: "password54321")
    post login_path, params: { user: { email_or_username: "user5", password: "password54321" } }

    assert_redirected_to receipes_path
    assert flash[:notice].to_s.include?("signed in")
  end
  
  test "cannot connect with invalid credentials" do
    post login_path, params: { user: { email_or_username: "user@example.com", password: "password12#{4}" } }

    assert_response :unprocessable_entity
    assert flash[:alert].to_s.include?("Incorrect credentials")
  end

  test "destroy cleanly user" do
    User.create!(email: "user3@example.com", username: "third_user", password: "password4321")
    post login_path, params: { user: { email_or_username: "user3@example.com", password: "password4321" } }

    delete logout_path
    assert_redirected_to root_url
  end
end
