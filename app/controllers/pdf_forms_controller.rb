class PdfFormsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :new, :update, :edit]

  def show    
    @pdf_form = PdfForm.find(params[:id])
    @repairs = @pdf_form.repairs.paginate(page: params[:page])
  end

  def new
    @user = current_user
    @customer = @user.customers.find(params[:customer_id])    
    @pdf_form = @customer.pdf_forms.build
    3.times { @pdf_form.repairs.build }
  end

  def create
    @user = current_user
    @customer = @user.customers.find(params[:customer_id])
    @pdf_form = @customer.pdf_forms.build(content: pdf_params.merge(customer_params), file: file_params)
    repair_params.each_value do |value|
      @pdf_form.repairs.build(value)
    end
    if @customer.save
      # if @pdf_form.fill
        flash[:success] = "PDF created!"
        redirect_to [@user, @customer]
      # else
      #   render 'new'
      # end
    else
      render 'new'
    end    
  end

  def edit
    @user = User.find(params[:user_id])
    @customer = @user.customers.find(params[:customer_id])
    @pdf_form = @customer.pdf_forms.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @customer = @user.customers.find(params[:customer_id])
    @pdf_form = @customer.pdf_forms.find(params[:id])  
    if @pdf_form.update_attributes(content: pdf_params, file: file_params)
      flash[:success] = "PDF updated"
      redirect_to [@user, @customer]
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
    def customer_params
      params.permit(:name, :phone, :license_plate)
    end

    def pdf_params
      # xxx require "0" since only 1 pdf allowed per customer creation...find better way xxx
      params.require(:pdf_form).require(:content)
    end

    def file_params
      if params[:pdf_form][:file]
        return params.require(:pdf_form).require(:file)
      else
        return nil
      end
    end

    def repair_params
      params.require(:pdf_form).require(:repairs_attributes)
    end    
end
