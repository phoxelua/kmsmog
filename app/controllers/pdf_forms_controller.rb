class PdfFormsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :new, :update, :edit]

  def show    
    @pdf_form = PdfForm.find(params[:id])
    @repairs = @pdf_form.repairs.paginate(page: params[:page])
  end


  def edit
    puts "in edit pdf "
    @user = User.find(params[:user_id])
    @customer = @user.customers.find(params[:customer_id])
    @pdf_form = @customer.pdf_forms.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @customer = @user.customers.find(params[:customer_id])
    @pdf_form = @customer.pdf_forms.find(params[:id])  
    p "params #{params}"
    p "pdf params #{pdf_params}"  
    p "file  #{file_params}"
    if @pdf_form.update_attributes(content: pdf_params, file: file_params)
      flash[:success] = "PDF updated"
      redirect_to [@user, @customer, @pdf_form]
    else
      render 'edit'
    end
  end

  def destroy
  	@pdf_form = PdfForm.find(params[:id])
    @pdf_form.destroy
    flash[:success] = "Pdf deleted"
    redirect_to request.referrer || root_url    
  end

  private

    def pdf_params
      # xxx require "0" since only 1 pdf allowed per customer creation...find better way xxx
      params.require(:pdf_form).require(:content)
    end

    def file_params
      params.require(:pdf_form).require(:file)
    end
end
