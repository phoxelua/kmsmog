require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  def setup
    @customer = customers(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Customer.count' do
      post :create, customer: { name: "Arthur Aardvark", phone: "619-123-4567", 
      							license_plate: "MyString", user: "michael" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Customer.count' do
      delete :destroy, id: @customer
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong customer" do
    log_in_as(users(:michael))
    customer = customers(:four)
    assert_no_difference 'Customer.count' do
      delete :destroy, id: customer
    end
    assert_redirected_to root_url
  end
end
