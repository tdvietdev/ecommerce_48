class UsersController < ApplicationController
  before_action :find_user, :logged_in_user, only: %i(edit update show)

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

  def show; end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".updated"
      redirect_to edit_user_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :phone, :address, :password,
      :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".find_user.notfound"
    redirect_to root_path
  end
end
