require 'test_helper'

class PdfFormTest < ActiveSupport::TestCase
  def setup
    @customer = customers(:one)
    @pdf_form = @customer.pdf_forms.build(content: {"odo" => 123, "invoice_no" => 1, "estimate" => 10})  
  end

  test "should be valid" do
    assert @pdf_form.valid?
  end

  # test "customer id should be present" do
  #   @pdf_form.customer_id = nil
  #   assert_not @pdf_form.valid?
  # end

  test "content should be present " do
    @pdf_form.content = {}
    assert_not @pdf_form.valid?
  end

  test "order should be most recent first" do
    assert_equal PdfForm.first, pdf_forms(:most_recent)
  end

  test "pdf_form should not have more than 12 repairs" do
    13.times {
      @pdf_form.repairs.build(op: 1,
                    instruction: "pls fix dis",
                    svc: 12)  
    }   
    assert_not @pdf_form.valid?
  end  

  test "odo key should be present" do
    pdf = @customer.pdf_forms.build(content: {"odo" => nil, "estimate" => 123, "invoice_no" => 10})
    assert_not pdf.valid?
  end

  test "estimate key should be present" do
    pdf = @customer.pdf_forms.build(content: {"odo" => 123, "estimate" => nil, "invoice_no" => 10})
    assert_not pdf.valid?
  end  

  test "invoice_no key should be present" do
    pdf = @customer.pdf_forms.build(content: {"odo" => 123, "estimate" => 1, "invoice_no" => nil})
    assert_not pdf.valid?
  end    
end
