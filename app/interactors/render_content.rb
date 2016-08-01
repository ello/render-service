class RenderContent
  include Interactor

  def call
    source = SourceContentItem.
             where(checksum: context.checksum).
             first_or_create(content: context.content)
    rendered = source.rendered_content_items.
               where(checksum: context.checksum, pipeline: context.pipeline).
               first_or_initialize
    render_content_for(rendered) if rendered.new_record?
    context.rendered_content = rendered.content
  end

  private

  def render_content_for(rendered)
    rendered.content = RenderPipeline.render(context.content, context: context.pipeline)
    context.fail! unless rendered.save
  end
end
