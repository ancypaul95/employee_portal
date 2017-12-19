require 'test_helper'

class EmployeesEditTest < ActionDispatch::IntegrationTest
  def setup
    @employee = employees(:example)
  end

  test "unsuccessful edit" do
    get edit_employee_path(@employee)
    assert_template 'employees/edit'
    patch employee_path(@employee), params: { employee: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'employees/edit'
  end
end
