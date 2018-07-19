class ProductsController < ApplicationController
  before_action :set_location, :load_categories
  before_action :load_product, except: %i(index)
  before_action :save_history, only: %i(show)

  def index
    @products = Product.includes(:category)
                    .search(params[:search]).desc_create_at.select_attr
                    .page(params[:page])
                    .per Settings.product.per_page
  end

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

  def save_history
    return unless logged_in?
    if current_user.visited_product? @product
      load_history(current_user, @product).touch
    else
      current_user.visited_product @product
    end
  end
end
