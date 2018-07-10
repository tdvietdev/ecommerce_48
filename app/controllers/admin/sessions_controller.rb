class Admin::SessionsController < ApplicationController
  layout "admin/application"

  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user &.authenticate(params[:session][:password])
      log_in user
      redirect_back_or admin_root_url
    else
      flash[:danger] = t ".warning"
      redirect_to admin_login_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to admin_root_url
  end
end
