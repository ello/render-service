class RenderedContentItem < ApplicationRecord

  belongs_to :source_content_item

  validates :content,
            :checksum,
            :pipeline,
            presence: true

  validates :pipeline,
            inclusion: { in: ->(_) { RenderPipeline.configuration.render_contexts.keys } }

  def self.matching_checksums_and_pipelines(array)
    conditions = array.map do |r|
      sanitize_sql_for_conditions(['(checksum = ? AND pipeline = ?)',  r['checksum'], r['pipeline']])
    end
    q = where(conditions * ' OR ')
    puts "=====QUERY====="
    puts q.to_sql
    puts "=====END====="
    q
  end
end
