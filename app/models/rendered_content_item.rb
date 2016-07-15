class RenderedContentItem < ApplicationRecord

  belongs_to :source_content_item

  validates :content,
            :checksum,
            :pipeline,
            presence: true

end
