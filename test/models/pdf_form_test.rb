require 'test_helper'

class PdfFormTest < ActiveSupport::TestCase
  def setup
    @customer = customers(:one)
    @pdf_form = @customer.pdf_forms.build(content: "{}")  
  end

  test "should be valid" do
    assert @pdf_form.valid?
  end

  # test "customer id should be present" do
  #   @pdf_form.customer_id = nil
  #   assert_not @pdf_form.valid?
  # end

  test "content should be present " do
    @pdf_form.content = "   "
    assert_not @pdf_form.valid?
  end

  test "order should be most recent first" do
    assert_equal PdfForm.first, pdf_forms(:most_recent)
  end

  test "pdf_form should not have more than 12 repairs" do
    13.times {
      @pdf_form.repairs.build(op: "idk what this is",
                    instruction: "pls fix dis",
                    svc: 12)  
    }   
    assert_not @pdf_form.valid?
  end  
end
