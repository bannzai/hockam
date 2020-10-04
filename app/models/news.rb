class News < ApplicationRecord
  mount_uploader :header_image, NewsUploader

  def displaing_descripton
    ActionController::Base.helpers.simple_format(description)
  end
end
