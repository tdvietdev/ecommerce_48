class CategoriesController < ApplicationController
  before_action :load_categories, :find_category

  def show
    @products = load_products(@category, params[:sort])
                .filter_by_min_price(params[:price_min])
                .filter_by_max_price(params[:price_max])
                .page(params[:page]).per 9
  end

  def find_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t ".notfound"
    redirect_to root_path
  end

  def load_products category, param
    case param
    when "2"
      category.get_all_product.order_by_name
    when "3"
      category.get_all_product.order_by_price_increase
    when "4"
      category.get_all_product.order_by_price_decrease
    else
      category.get_all_product.order_by_create_at
    end
  end
end
