module ProductsHelper
  def product_avatar product
    return image_tag(product.avatar.image.url) if product.avatar
    image_tag "product01.png"
  end

  def get_image_url product
    return image_url ("product01.png") unless product.avatar
    image_url(product.avatar.image.url)
  end

  def new_products
    Product.order_by_create_at.limit(20)
  end
end
