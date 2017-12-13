require 'test_helper'

class EmployeesSignupTest < ActionDispatch::IntegrationTest
  test "valid signup information" do
    get signup_path
    assert_difference 'Employee.count', 1 do
      post employees_path, params: { employee: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'employees/show'
    assert is_logged_in?
  end
end
