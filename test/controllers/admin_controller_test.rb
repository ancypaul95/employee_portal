require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest

  def setup
    @admin = employees(:admin)
  end

  test "should get new" do
    get adminlogin_path  
    assert_response :success
  end

  test "should get home" do
    log_in_as(@admin)
    get adminhome_path
    assert_response :redirect
  end

  test "should get index" do
    log_in_as(@admin)
    get adminemployee_path
    assert_response :redirect
  end

  test "should get projects" do
    log_in_as(@admin)
    get adminproject_path
    assert_response :redirect
  end

end
 