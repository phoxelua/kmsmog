class StaticPagesController < ApplicationController
  def home
    @customer = current_user.customers.build if logged_in?
  end

  def about
  end

  def help
  end  
end
