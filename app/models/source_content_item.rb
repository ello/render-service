class SourceContentItem < ApplicationRecord

  validates :content,
            :checksum,
            presence: true

  has_many :rendered_content_items

end
