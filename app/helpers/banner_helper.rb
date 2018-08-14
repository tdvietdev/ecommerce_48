module BannerHelper
  def get_image banner
    return image_tag(banner.picture.url) if banner.picture.url
    image_tag "default_logo.png"
  end
end
