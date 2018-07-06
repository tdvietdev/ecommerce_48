class ProductsController < ApplicationController
  before_action :load_product, :set_location, :load_categories

  def show
    @category = @product.category
    return unless logged_in?
    @rate = Rate.find_by user_id: current_user.id,
      product_id: params[:id]
  end

  def set_location
    return if logged_in?
    store_location
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def find_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t ".notfound"
    redirect_to root_path
  end
end
