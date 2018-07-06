module OrdersHelper
  def price_item key
    Product.find_by(id: key).current_price
  end
end
