class UsersController < ApplicationController
  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".welcome"
      redirect_to root_path
    else
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :phone, :address, :password,
      :password_confirmation
  end
end
