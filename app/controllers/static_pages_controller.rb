class StaticPagesController < ApplicationController
  include ProductsHelper
  before_action :load_categories, :load_cart, only: %i(home)

  def home
    @new_products = new_products
    @top_seller_products = Product.top_order
  end

  def help; end
end
