module CartsHelper
  def total_money
    @cart = session[:cart]
    sum = 0
    @cart.each do |key, val|
      sum += val * Product.by_id(key)[0].current_price
    end
    sum
  end

  def total_quantity
    @cart = session[:cart]
    sum = 0
    @cart.each do |_key, val|
      sum += val
    end
    sum
  end

  def total_each item
    cart = session[:cart]
    cart[item.id.to_s] * item.current_price
  end

  def quantity item
    cart = session[:cart]
    cart[item.id.to_s]
  end

  def show_cart
    cart = session[:cart]
    product_ids = cart.map{|key, _value| key}
    Product.includes(:promotions).by_product_id(product_ids)
  end
end
