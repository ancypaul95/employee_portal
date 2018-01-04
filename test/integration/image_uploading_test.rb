require 'test_helper'

class ImageUploadingTest < ActionDispatch::IntegrationTest
  def setup
    @employee = employees(:example)
  end

  test "image uploading" do
    get login_path
    post login_path, params: { session: { email:    @employee.email,
                                          password: 'password' } }
    get edit_employee_path(@employee)
    assert_template 'employees/edit'
  end
end
