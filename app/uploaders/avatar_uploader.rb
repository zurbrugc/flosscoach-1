# encoding: utf-8
class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :standard do
    process :resize_to_fill => [100, 150, :north]
  end
  version :medium do
    process :resize_to_fill => [100, 150, :north]
  end
  version :thumbnail do
    process :resize_to_fit => [50, 50]
  end
  version :thumb do
    process :resize_to_fit => [50, 50]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def content_type_whitelist
    /image\//
  end
  
end
