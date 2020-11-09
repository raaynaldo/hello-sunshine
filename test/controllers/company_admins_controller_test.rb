require 'test_helper'

class CompanyAdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get company_admins_new_url
    assert_response :success
  end

end
