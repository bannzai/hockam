class News < ApplicationRecord
  mount_uploader :header_image, NewsUploader
end
