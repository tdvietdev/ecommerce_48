class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  include SessionsHelper
  include CartsHelper
  include OrdersHelper
  include HistoriesHelper
  include ApplicationHelper

  class << self
    def permission
      return name.gsub("Controller", "").singularize.split("::").last.underscore
    end
  end

  private
  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def logged_in_user
    return if user_signed_in?
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
