class SourceContentItem < ApplicationRecord

  validates :content,
            :checksum,
            presence: true

  has_many :rendered_content_items

  def rendered_content_for(pipeline)
    rendered_content_items.where(pipeline: pipeline).first!.content
  end
end
