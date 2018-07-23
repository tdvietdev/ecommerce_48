class Admin::AdminController < ApplicationController
  layout "admin/application"

  before_action :logged_in_user

  private
  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = t ".danger"
    redirect_to admin_login_path
  end
end
