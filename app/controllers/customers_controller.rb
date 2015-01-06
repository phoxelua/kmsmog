class CustomersController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :new]
  before_action :correct_user,   only: [:destroy]

  def show    
    @customer = Customer.find(params[:id])
    @pdf_forms = @customer.pdf_forms.paginate(page: params[:page])
  end

  def new
    @user = current_user
    @customer = @user.customers.build
    @pdf_form = @customer.pdf_forms.build
    2.times { @pdf_form.repairs.build }
  end

  def create
    @user = current_user
    @customer = @user.customers.new(customer_params)
    @pdf_form = @customer.pdf_forms.build(content: pdf_params.merge(customer_params), file: file_params[:file])
    repair_params.each_value do |value|
      @pdf_form.repairs.build(value)
    end
    if @customer.save
      @pdf_form.fill @customer
      flash[:success] = "Customer created!"
      redirect_to root_url
      # redirect_to @customer
    else
      render 'new'
    end
  end

  def destroy
    @customer.destroy
    flash[:success] = "Customer deleted"
    redirect_to request.referrer || root_url    
  end

  private

    def customer_params
      params.require(:customer).permit(:name, :phone, :license_plate)
    end

    def pdf_params
      # xxx require "0" since only 1 pdf allowed per customer creation...find better way xxx
      params.require(:customer).require(:pdf_forms_attributes).require("0").require(:formy)
      # params.require(:customer).except!(:name, :phone, :license_plate)
      #               .permit(pdf_forms_attributes: [:id , {formy: [ :emaily, :phone]}])
                    # .permit(pdf_forms_attributes: [{id: [:formy]}])
    end

    def file_params
      params.require(:customer).require(:pdf_forms_attributes).require("0").permit(:file)      
    end

    def repair_params
      params.require(:customer).require(:pdf_forms_attributes).require("0").require(:repairs_attributes)
    end

    
    def correct_user
      @customer = current_user.customers.find_by(id: params[:id])
      redirect_to root_url if @customer.nil?
    end    
end
