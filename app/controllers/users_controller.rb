class UsersController < ApplicationController
  before_action :find_user, :logged_in_user, only: %i(edit update show)
  before_action :load_categories

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".updated"
      redirect_to edit_user_path
    else
      render :edit
    end
  end

  def order_history
    @orders = Order.where(user_id: current_user.id)
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
