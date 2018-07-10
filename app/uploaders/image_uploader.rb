class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fit: [120, 120]
  end

  version :default do
    process resize_to_fit: [600, 600]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
