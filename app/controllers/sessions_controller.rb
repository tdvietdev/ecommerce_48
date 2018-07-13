class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user &.authenticate(params[:session][:password])
      log_in user
      redirect_back_or root_url
    else
      flash.now[:danger] = t ".warning"
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
