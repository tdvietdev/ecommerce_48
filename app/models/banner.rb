class Banner < ApplicationRecord
  mount_uploader :picture, BannerUploader
  validates :title, length: {
      maximum: Settings.banner.max_title, minimum: Settings.banner.min_title
  }

  scope :list_actived, ->{where active: true}
end
