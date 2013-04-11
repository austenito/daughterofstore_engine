class Admin::StoresController < ApplicationController
  before_filter :require_platform_admin

  def index
    @stores = Store.all
  end

  def update
    @store = Store.find(params[:id])
    if @store.update_attributes(params[:store])
      redirect_to admin_stores_path,
        :notice  => "Successfully updated store."
    else
      render :action => 'edit', :notice  => "Update failed."
    end
  end

  def choose_approval_status
    store = Store.find_by_id(params[:id])
    store.approval_status = params[:status]
    store.save
    redirect_to admin_stores_path
  end
end