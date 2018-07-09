module ProductsHelper
  def product_avatar product
    return image_tag(product.avatar.image.url) if product.avatar
    image_tag "product01.png"
  end

  def new_products
    Product.order_by_create_at.limit(20)
  end
end
