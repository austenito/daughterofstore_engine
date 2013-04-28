class ProductsController < ApplicationController
  def index
    if current_store.pending?
        redirect_to root_path,
                        alert: "The store you are looking for does not exist."
        return
    elsif current_store.active == false && current_store.approved?
      redirect_to root_path,
              alert: "#{current_store.name} is currently down for maintenance."
      return
    elsif current_store.approved?
      @top_products = current_store.top_products
      begin
        @products = current_store.filter_products_by_category(params[:category_id]).page(params[:page]).per(40)
      rescue
        flash.alert = "The category doesn't exist"
        @products = current_store.products.page(params[:page]).per(40)
      end
      @categories = current_store.categories
    else
      redirect_to root_path,
        alert: "The store you are looking for does not exist."
      return
    end
  end

  def show
    # session[:return_to] = request.fullpath
    @store ||= current_store
    @product ||= @store.products.find(params[:id]) if @store
    if @product
      render :show
    else
      redirect_to root_path,
      alert: "The product you are looking for does not exist."
    end
  end
end
