class Admin::StaticPagesController < Admin::AdminController
  authorize_resource class: false

  def index
    @options = {
      1 => "user", 2 => "product_order", 3 => "revenue",
      4 => "order_quantity", 5 => "product"
    }
    @objects = load_objects(params[:option])
    respond_to do |format|
	    format.html
	    format.xls {
        filename = I18n.t("report.base") + "#{@options[params[:option].to_i]} #{Time.now.strftime("%Y%m%dH%M%S")}.xls"
        send_data to_xls(@objects, params[:option], col_sep: "\t"), filename: filename }
	  end
  end

  def load_objects param
    case param
    when "1"
      User.filter(params[:start_date], params[:end_date])
          .group_by_day(:created_at).count
    when "2"
      Product.top_order(params[:start_date], params[:end_date])
             .map{|product| [product.name, product.total]}
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

  def to_xls(objects, param, options = {})
    CSV.generate(options) do |csv|
      case param
      when "1", "4"
        csv << [I18n.t("report.datetime"), I18n.t("report.quantity")]
      when "2"
        csv << [I18n.t("report.product"), I18n.t("report.quantity")]
      when "3"
        csv << [I18n.t("report.datetime"), I18n.t("report.total_money")]
      when "5"
        csv << [I18n.t("report.product"), I18n.t("report.total_money")]
      end
      objects.each do |key, val|
        csv << [key, val]
      end
    end
  end
end
