class HistoriesController < ApplicationController
  before_action :load_user, :load_categories, only: %i(index)
  def index
    @histories = @user.histories.lasted_visit.page(params[:page]).per 6
    @products = @histories.map(&:product)
  end
  private
  def load_user
    @user = User.find_by id: params[:user_id]
    return if @user
    flash[:danger] = t ".find_user.notfound"
    redirect_to root_path
  end
end
