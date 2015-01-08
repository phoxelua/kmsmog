class PdfFormsController < ApplicationController

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
    # @user = User.find(params[:user_id])
    # @customer = @user.customers.find(params[:id])
    # if @customer.update_attributes(customer_params)
    #   flash[:success] = "Customer profile updated"
    #   redirect_to [@user, @customer]
    # else
    #   render 'edit'
    # end
  end

  def destroy
  	@pdf_form = PdfForm.find(params[:id])
    @pdf_form.destroy
    flash[:success] = "Pdf deleted"
    redirect_to request.referrer || root_url    
  end
end
