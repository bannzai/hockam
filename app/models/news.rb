class News < ApplicationRecord
  mount_uploader :header_image, NewsUploader


  REDCARPET_CONFIG = {
    fenced_code_blocks: true,
    autolink: true,
  }.freeze

  def displaing_descripton
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, REDCARPET_CONFIG)
    markdown.render(description).html_safe
  end
end
