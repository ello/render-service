class RenderedContentItem < ApplicationRecord

  belongs_to :source_content_item

  validates :content,
            :checksum,
            :pipeline,
            presence: true

  validates :pipeline,
            inclusion: { in: ->(_) { RenderPipeline.configuration.render_contexts.keys } }

end
