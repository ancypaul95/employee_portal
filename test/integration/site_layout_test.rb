require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    #assert_template 'sessions/new'
    assert_template 'employee_pages/home'
  end
end
