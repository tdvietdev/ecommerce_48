module OrdersHelper
  def price_item key
    Product.find_by(id: key).current_price
  end

  def name_item product_id
    Product.find_by(id: product_id).name
  end

  def total_each_order_detail order_detail
    order_detail.price * order_detail.quantity
  end
end
