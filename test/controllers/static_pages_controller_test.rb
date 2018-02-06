require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url

    follow_redirect!
    
    assert_template 'sessions/new'
  end
end
