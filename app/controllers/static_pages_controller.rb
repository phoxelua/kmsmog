class StaticPagesController < ApplicationController
  def home
    @customer = current_user.customers.build if logged_in?
    # @pdf_form = @customer.pdf_forms.build if !@customer.nil?
  end

  def about
  end

  def help
  end  
end
