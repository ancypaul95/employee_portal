require 'test_helper'

class EmployeesLoginTest < ActionDispatch::IntegrationTest
  def setup
    @employee = employees(:example)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email:    @employee.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @employee
    follow_redirect!
    assert_template 'employees/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", employee_path(@employee)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path        
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", employee_path(@employee), count: 0
  end

  test "login with remembering" do
    log_in_as(@employee, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@employee, remember_me: '1')
    # Log in again and verify that the cookie is deleted.
    log_in_as(@employee, remember_me: '0')
    assert_empty cookies['remember_token']
  end

end
