require 'test_helper'

class AdminIndexTest < ActionDispatch::IntegrationTest
  def setup
    @employee = employees(:example)
  end

  test "index including pagination" do
    log_in_as(@employee)
    get adminemployee_path
    assert_template 'admin/index' 
    assert_select 'div.pagination'
    Employee.paginate(page: 1,per_page: 10).each do |employee|
      assert_select 'a[href=?]', showemployee_path(:id => employee.id), text: employee.name if employee.admin.nil?
    end
  end
end

