# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [50, 50, gravity = ::Magick::CenterGravity]
  end

  # 画像の上限を指定する
  process resize_to_limit: [200, 200]

  # 受け付けるのはjpg, jpeg, pngのみ
  def extension_white_list
    %w(jpg jpeg png)
  end

  # 拡張子が同じではないとコンバートできないので、ファイル名を変更
  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end
end
