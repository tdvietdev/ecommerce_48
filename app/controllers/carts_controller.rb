class CartsController < ApplicationController
  before_action :load_cart, only: %i(update_item add_product delete_item)

  def view; end

  def delete_item
    @cart.delete(params[:key])
  end

  def add_product
    if Product.find_by id: params[:key]
      key = params[:key].to_s
      value = params[:value] ? params[:value].to_i : 1
      @cart[key] = @cart[key] ? @cart[key] + value : value
      @products = show_cart
    else
      flash[:danger] = "product not fount!"
      redirect_to root_path
    end
  end

  def update_item
    @cart[params[:key]] = params[:quantity].to_i
    respond_to do |format|
      format.js
    end
  end

  def destroy
    session[:cart] = nil if session[:cart]
    redirect_to root_path
  end
end
