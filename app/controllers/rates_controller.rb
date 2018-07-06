class RatesController < ApplicationController
  before_action :logged_in_user, :find_rate, :find_product

  def new; end

  def create
    if @rate.nil?
      @rate = Rate.create rate_params
    else
      @rate.update_attributes rate_params
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def rate_params
    params.require(:rate).permit :id, :user_id, :product_id, :score
  end

  def find_rate
    @rate = Rate.find_by user_id: rate_params[:user_id],
      product_id: rate_params[:product_id]
  end

  def find_product
    @product = Product.find_by id: rate_params[:product_id]
  end
end
