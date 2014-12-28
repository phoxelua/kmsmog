require 'test_helper'

class QueryTest < ActiveSupport::TestCase

  def setup
    @query = Query.new(name: "Example Name", 
    				 phone: "555-1234567",
    				 license_plate: "ABC2345")
  end

  test "should be valid" do
    assert @query.valid?
  end

  test "at least one of three fields should be present" do
  	@query.name = ""
  	@query.phone = ""
  	@query.license_plate = ""  	
  	assert_not @query.valid?
  end

  test "name should not be too long" do
  	@query.name = "a" * 51
  	assert_not @query.valid?
  end

  test "phone number should not be too long" do
  	@query.phone = "1" * 11
  	assert_not @query.valid?
  end

  test "license plate should not be too long" do
  	@query.license_plate = "1" * 21 #made up constraint
  	assert_not @query.valid?
  end

  test "valid phone number shorthands should be valid" do
  	@query.phone = "8-123-4567"
  	assert @query.valid?
  end

  test "invalid phone number shorthands should be invalid" do
  	@query.phone = "7-666-8910"
  	assert_not @query.valid?
  end


end
