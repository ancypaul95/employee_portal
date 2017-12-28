require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
    test "should get new" do
        get addemployee_path
        assert_response :success
    end
end
