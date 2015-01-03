require 'test_helper'

class RepairTest < ActiveSupport::TestCase
  def setup
    @pdf_form = pdf_forms(:orange)
    @repair = @pdf_form.repairs.build(op: 1,
    								instruction: "pls fix dis",
    								svc: 12)  
  end

  test "should be valid" do
    assert @repair.valid?
  end

  test "instruction should be present " do
    @repair.instruction = ""
    assert_not @repair.valid?
  end

  test "svc should be present " do
    @repair.svc = nil
    assert_not @repair.valid?
  end

  test "instruction should be not too long " do
    @repair.instruction = "a" * 101
    assert_not @repair.valid?
  end
end
