class OrdersController < ApplicationController
  before_action :load_categories, :load_cart
  def new
    @order = Order.new
  end

  def create
    @order = Order.new order_params
    @order.grand_total = total_money
    @flag = ActiveRecord::Base.transaction do
      @order.save!
      @cart.each do |key, val|
        @order_detail = OrderDetail.create!(product_id: key.to_i,
          order_id: @order.id, quantity: val, price: price_item(key.to_i))
      end
    end
    session[:cart] = nil
    flash[:success] = t "controller.orders.create_order_success"
    redirect_to root_path
    rescue Exception => ex
      render :new
  end

  private
  def order_params
    params.require(:order).permit :user_id, :status, :address, :phone, :comment
  end
end
