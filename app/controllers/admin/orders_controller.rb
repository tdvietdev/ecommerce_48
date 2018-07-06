class Admin::OrdersController < Admin::AdminController
  before_action :load_order, only: %i(edit update show)

  def index
    @orders = Order.select_attr.includes(:user)
                   .includes(:order_details)
                   .page(params[:page])
                   .sort_by_status.sort_by_create_at
                   .per Settings.order.per_page
  end

  def show; end

  def edit
    @order_details = OrderDetail.eager_load(:product).by_order @order.id
  end

  def update
    if @order.update order_params
      flash[:success] = t ".success"
      redirect_to admin_orders_path
    else
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def order_params
    params.require(:order).permit :status
  end

  def load_order
    @order = Order.includes(:user).find_by id: params[:id]
    return if @order
    flash[:danger] = t ".not_found"
    redirect_to admin_orders_path
  end
end
