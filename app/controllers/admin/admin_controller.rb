class Admin::AdminController < ApplicationController
  protect_from_forgery
  layout "admin/application"

  before_action :logged_in_user

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = I18n.t "cancancan.not_permission"
    flash[:alert] = exception
    redirect_to root_path
  end

  private
  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = t ".danger"
    redirect_to admin_login_path
  end

  def current_ability
    controller_name_segments = params[:controller].split "/"
    controller_name_segments.pop
    controller_name_segments.join("/").camelize
    Ability.new current_user
  end
end
