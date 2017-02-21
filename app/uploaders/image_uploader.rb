# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # 保存先はassets以下
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # 画像のサイズの上限を200pxに設定
  process resize_to_limit: [200, 200]

  # 保存形式をJPGにする
  process convert: 'jpg'

  # 拡張子をjpg, jpeg, pngに指定
  def extension_white_list
    %w(jpg jpeg png)
  end
end
