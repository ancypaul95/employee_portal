require 'test_helper'

class EmployeesSignupTest < ActionDispatch::IntegrationTest

  def setup
    @admin = employees(:admin)
  end

  test "invalid signup information" do
    get adminlogin_path
    post adminlogin_path, params: { session: { email:    @admin.email,
                                          password: 'password' } }
    get addemployee_path
    assert_no_difference 'Employee.count' do
      post addemployee_path, params: { employee: { name:  "",
                                         email: "user@invalid",
                                         designation:"qaz",
                                         phone:"123aw12902",
                                         gender:"m",
                                         dateofjoin:"12/11/2017",
                                         address:"qwerty",
                                         active:"j",
                                         username:"user",
                                         password:"foo",
                                         password_confirmation:"bar" } }
    end
    assert_template 'admin/addemployee'
  end

  test "valid signup information" do
    get adminlogin_path
    post adminlogin_path, params: { session: { email:    @admin.email,
                                          password: 'password' } }
    get addemployee_path
    assert_difference 'Employee.count', 1 do
    post addemployee_path, params: { employee: { name:  "Example User",
                                        email: "user@example.com",
                                        designation:"tester",
                                        phone:"1234567890",
                                        gender:"male",
                                        dateofjoin:"12/11/2017",
                                        address:"qwerty",
                                        active:"true",
                                        username:"username",
                                        password:"password",
                                        password_confirmation:"password" } }
    end
    follow_redirect!
    assert_template 'admin/index'
  end
end
