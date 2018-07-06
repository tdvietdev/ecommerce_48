module ProductsHelper
  def product_avatar product
    return image_tag(product.avatar.image.url) if product.avatar
    image_tag "product01.png"
  end
end
