class PdfFormsController < ApplicationController
  def show    
    @pdf_form = PdfForm.find(params[:id])
    @repairs = @pdf_form.repairs.paginate(page: params[:page])
  end
end
