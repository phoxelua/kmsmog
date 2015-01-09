require 'test_helper'

class LayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'users/show'
    assert_select "a[href=?]", root_path, count: 4
    assert_select "a[href=?]", about_path, count:2
    assert_select "a[href=?]", contact_path
  end
  
end
