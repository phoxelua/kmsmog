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
    puts "customer_params"
    puts customer_params
    @customer = @user.customers.new(customer_params)
    puts "pdf_params"
    puts pdf_params
    @pdf_form = @customer.pdf_forms.build(content: pdf_params)
    puts "repair_params"
    puts repair_params
    @repair = @pdf_form.repairs.build(pdf_params)
    puts "trying to create!!!!!!!!"
    p @user
    p @customer
    p @pdf_form
    p @repair
    if @customer.save
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
      # params.permit(:user_id)
      # params.require(:customer).permit!()
      # causes wierd errror
      params.require(:customer).permit(:name, :phone, :license_plate)
      # params.require(:customer).permit(:name, :phone, :license_plate, 
                # pdf_forms_attributes: [:id , {formy: :email}])
    end

    def pdf_params
      params.require(:customer).require(:pdf_forms_attributes).require("0").require(:formy)
      # params.require(:customer).except!(:name, :phone, :license_plate)
      #               .permit(pdf_forms_attributes: [:id , {formy: [ :emaily, :phone]}])
                    # .permit(pdf_forms_attributes: [{id: [:formy]}])
    end

    def repair_params
      params.require(:customer).require(:pdf_forms_attributes).require("0").require(:repairs_attributes)
    end

    
    def correct_user
      @customer = current_user.customers.find_by(id: params[:id])
      redirect_to root_url if @customer.nil?
    end    
end
