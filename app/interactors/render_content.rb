class RenderContent
  include Interactor

  def call
    source = SourceContentItem.
             where(checksum: context.checksum).
             first_or_initialize(content: context.content)
    render_content_for(source) if source.new_record?
    context.fail! unless source.save
    context.rendered_content = source.rendered_content_for(context.pipeline) if context.pipeline.present?
  end

  private

  def render_content_for(source)
    RenderPipeline.configuration.render_contexts.each_key do |pipeline|
      content = RenderPipeline.render(source.content, context: pipeline)
      source.rendered_content_items.build(
        pipeline: pipeline,
        content: content,
        checksum: source.checksum
      )
    end
  end
end
