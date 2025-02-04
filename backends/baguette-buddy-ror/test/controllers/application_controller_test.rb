require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to root when html not authenticated" do
    get receipes_path

    assert_redirected_to root_path
    assert flash[:notice].to_s.include?("Please sign in to continue.")
  end
  
  test "should return unauthorized when json nd not authenticated" do
    get receipes_path, as: :json

    assert_response :unauthorized
    assert_equal "{\"error\":\"Unauthorized\"}", response.body
  end
end