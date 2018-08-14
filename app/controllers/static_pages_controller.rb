class StaticPagesController < ApplicationController
  include ProductsHelper
  before_action :load_categories, :load_cart, only: %i(home)

  def home
    @new_products = Product.includes(:images, :promotions).new_products
    @top_seller_products = Product.includes(:images, :promotions)
      .top_order.limit Settings.product.top_seller
    @banners = Banner.list_actived.limit Settings.banner.limit
  end

  def help; end
end
