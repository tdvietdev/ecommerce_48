class Image < ApplicationRecord
  belongs_to :product

  mount_uploader :image, ImageUploader
  before_save :set_avatar

  def self.get_avatar
    where(avatar: true).first
  end

  def name
    image.url.to_s.split("/").last
  end

  private
  def set_avatar
    self.avatar = true if product.avatar.nil?
  end
end
