class BillingAddressesController < ApplicationController
  before_filter :require_login

  def new
    @billing_address = BillingAddress.new
  end

  def create
    @billing_address = BillingAddress.new(params[:billing_address])

    if @billing_address.save
      if session[:return_to] == profile_url(current_user)
        redirect_to profile_path(current_user)
      else
        redirect_to new_customer_credit_cards_path(current_user)
      end
    else
      render "new"
    end
  end

  def edit
    @billing_address = BillingAddress.find_by_customer_id(current_user.customer.id)
  end

  def update
    @billing_address = BillingAddress.find_by_customer_id(current_user.customer.id)

    if @billing_address.update_attributes(params[:billing_address])
      redirect_to profile_path,
        :notice  => "Successfully updated billing address."
    else
      render :action => 'edit', :notice  => "Update failed."
    end
  end
end
