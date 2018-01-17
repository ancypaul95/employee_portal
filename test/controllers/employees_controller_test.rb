require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @employee = employees(:example)
  end

  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should get home" do
    log_in_as(@employee)
    get home_path
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@employee)
    get edit_employee_path(@employee)
    assert_response :success
  end
end
