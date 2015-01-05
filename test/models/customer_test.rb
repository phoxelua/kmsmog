require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @customer = @user.customers.build(name: "Example Name",  phone: "555-1234567",
    				 		license_plate: "ABC2345")
  end

  test "should be valid" do
    assert @customer.valid?
  end

  test "user id should be present" do
    @customer.user_id = nil
    assert_not @customer.valid?
  end

  test "at least one of three identifier fields should be present" do
  	@customer.name = ""
  	@customer.phone = ""
  	@customer.license_plate = ""  	
  	assert_not @customer.valid?
  end

  test "name should not be too long" do
  	@customer.name = "a" * 51
  	assert_not @customer.valid?
  end

  test "phone number should not be too long" do
  	@customer.phone = "1" * 11
  	assert_not @customer.valid?
  end

  test "license plate should not be too long" do
  	@customer.license_plate = "1" * 21 #made up constraint
  	assert_not @customer.valid?
  end

  test "valid phone number shorthands should be valid" do
  	@customer.phone = "8-123-4567"
  	assert @customer.valid?
  end

  test "invalid phone number shorthands should be invalid" do
  	@customer.phone = "7-666-8910"
  	assert_not @customer.valid?
  end

  test "order should be alphabetical first" do
    assert_equal Customer.first,customers(:smallest_lexi)
  end

  test "associated pdf_forms should be destroyed" do
    @customer.save
    @customer.pdf_forms.create!(content: {"odo" => 123, "original_estimate" => 1, "invoice" => 10})
    assert_difference 'PdfForm.count', -1 do
      @customer.destroy
    end
  end   
end
