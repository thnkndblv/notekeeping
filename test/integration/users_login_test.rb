require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_a)
  end

  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new'

    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
  end

  test 'login with valid information' do
    get login_path
    post login_path, params: {
      session: {
        email: @user.email,
        password: 'password'
      }
    }

    assert_redirected_to @user
    follow_redirect!

    assert_template 'users/show'
    assert is_logged_in?

    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
  end
end
