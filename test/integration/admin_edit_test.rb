require 'test_helper'

class AdminEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = employees(:admin)
    @employee = employees(:example)
  end

  test "unsuccessful edit" do
    get adminlogin_path
    assert_template 'adminsession/new'
    post adminlogin_path, params: {session: { email: @admin.email,
                                             password:'password' }}
    get adminedit_path(:id => @employee.id)
    assert_template 'admin/edit'
    patch adminedit_path(:id => @employee.id),params: { employee: { 
                                                                    name: "abc",
                                                                    email: "foo@invalid",
                                                                    designation:"foo",
                                                                    phone: "123aw45678",
                                                                    dateofjoin:"qwe",
                                                                    gender:"tyu",
                                                                    address:"fooinvalid",
                                                                    active:"q" } }
    assert_redirected_to adminedit_path
  end

  test "successful edit" do
    get adminlogin_path
    assert_template 'adminsession/new'
    post adminlogin_path, params: {session: { email: @admin.email,
                                             password:'password' }}
    get adminedit_path(:id => @employee.id)
    assert_template 'admin/edit'
    patch adminedit_path(:id => @employee.id),params: { employee: { 
                                                                    name: "Example",
                                                                    email: "example@mail.com",
                                                                    designation:"developer",
                                                                    phone: "1233445678",
                                                                    dateofjoin:"12/12/2017",
                                                                    gender:"male",
                                                                    address:"savhfakf sdagfklweajf dfjejf",
                                                                    active:"t" } }
    assert_not flash.empty?
    assert_redirected_to adminemployee_path
  end
end
