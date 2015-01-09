class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :dashboard, :index, :destroy, :show]
  before_action :correct_user,   only: [:edit, :update, :dashboard, :show]
  before_action :admin_user,     only: [:destroy, :index]


  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
    if params[:search]
      condition_left = []
      condition_right = []
      if !params[:search]["name"].blank?
        condition_left += ['name LIKE ?']
        condition_right += ["%#{params[:search]['name']}%"]
      end
      if !params[:search]["phone"].blank?
        condition_left += ['phone LIKE ?']
        condition_right += ["%#{params[:search]['phone']}%"]
      end
      if !params[:search]["license_plate"].blank?
        condition_left += ['license_plate LIKE ?']
        condition_right += ["%#{params[:search]['license_plate']}%"]
      end
      conditions = [condition_left.join(" AND ")]
      conditions += condition_right
      @customers = @user.customers.where(conditions).paginate(page: params[:page])
    else
      params.merge!(:search => {})
      @customers = @user.customers.paginate(page: params[:page])    
    end
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
    	flash[:success] = "Welcome to the Smaug!"
    	redirect_to @user #redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # @user.update_attributes(user_params)
    # respond_with @user
    if @user.update_attributes(user_params)
      flash[:success] = "User profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end  

  private

    def user_params
      params.require(:user).permit(:name, :email, :organization, :password,
                                   :password_confirmation)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end    
end
