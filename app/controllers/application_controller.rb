class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  include CartsHelper
  include OrdersHelper

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t ".danger"
    redirect_to root_path
  end

  def load_categories
    @categories = Category.roots
  end

  def load_cart
    @cart = current_cart
    flash[:danger] = t("controller.carts.cart_not_found") if @cart.nil?
  end

  def current_cart
    session[:cart] ||= {}
  end
end
