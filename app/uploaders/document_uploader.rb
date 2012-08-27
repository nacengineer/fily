require 'carrierwave/datamapper'

class DocumentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # storage :file

  def store_dir
    "uploads/documents/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(docx pdf)
  end

  # version :thumb do
  #   process :resize_to_fill => [200,200]
  # end

end