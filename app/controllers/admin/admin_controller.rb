class Admin::AdminController < ApplicationController
<<<<<<< HEAD
  layout "admin/application"

  before_action :logged_in_user, :ensure_admin

  private

  def ensure_admin
    return if current_user.admin?
    flash[:danger] = t ".admin"
    redirect_to admin_login_path
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t ".danger"
    redirect_to admin_root_path
  end
=======
  # before_action :authenticate_user!
  # before_action :ensure_admin!

  layout "admin/application"

  # def ensure_admin!
  #   return if current_user.admin?
  #   flash[:danger] = t "flash.not_permitted"
  #   redirect_to root_path
  # end
>>>>>>> add category
end
