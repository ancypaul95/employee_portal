require 'test_helper'

class AdminIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = employees(:admin)
  end

  test "index including pagination" do
    get adminlogin_path
    post adminlogin_path, params: { session: { email:    @admin.email,
                                          password: 'password' } }
    get adminemployee_path
    assert_template 'admin/index'
    assert_select 'div.pagination'
    Employee.paginate(page: 1,per_page: 10).each do |employee|
      assert_select 'a[href=?]', showemployee_path(:id => employee.id),
       text: employee.name if employee.admin.nil?
    end
  end
end
    
