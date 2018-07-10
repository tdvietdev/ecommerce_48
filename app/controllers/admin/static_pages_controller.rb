class Admin::StaticPagesController < Admin::AdminController
  Groupdate.time_zone = false
  def index
    @options = {
      1 => "user", 2 => "product_order", 3 => "revenue",
      4 => "order_quantity", 5 => "product"
    }
    @objects = load_objects(params[:option])
  end

  def load_objects param
    case param
    when "1"
      User.filter(params[:start_date], params[:end_date])
          .group_by_day(:created_at).count
    when "2"
      Product.top_order.map{|product| [product.name, product.total]}
    when "3"
      Order.filter(params[:start_date], params[:end_date])
        .group_by_day(:created_at).sum_money
    when "4"
      Order.filter(params[:start_date], params[:end_date])
           .group_by_day(:created_at).count
    when "5"
      Product.top_revenue.map{|product| [product.name, product.total]}
    else
      Order.filter(params[:start_date], params[:end_date])
          .group_by_day(:created_at).sum_money
    end
  end
end
