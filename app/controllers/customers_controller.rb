class CustomersController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def show    
    @customer = Customer.find(params[:id])
    @pdf_forms = @customer.pdf_forms.paginate(page: params[:page])
  end

  def new
    @customer = current_user.customers.new(customer_params)
    @pdf_form = @customer.pdf_forms.build 
  end

  def create
    @customer = current_user.customers.new(customer_params)
    @pdf_form = @customer.pdf_forms.build
    if @customer.save
      flash[:success] = "Customer created!"
      redirect_to root_url
      # redirect_to @customer
    else
      render 'new'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url    
  end

  private

    def customer_params
      params.require(:customer).permit!()
      # causes wierd errror
      # params.require(:customer).permit(:name, :phone, :license_plate, 
      #           pdf_forms_attributes: [:id , {form: :email}])
    end
    
    def correct_user
      @customer = current_user.customers.find_by(id: params[:id])
      redirect_to root_url if @customer.nil?
    end    
end
