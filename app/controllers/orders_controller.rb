class OrdersController < ApplicationController
  before_action :load_categories, :load_cart
  before_action :logged_in_user, only: %i(new create)
  def new
    if @cart.empty?
      flash[:danger] = "Ban chua chon hang"
      redirect_to root_path
    end
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
    OrderMailer.order_infomation(@order).deliver_now
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
