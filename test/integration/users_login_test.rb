require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with valid information followed by logout" do
    delete logout_path
  end
end
