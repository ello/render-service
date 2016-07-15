class RenderContent
  include Interactor

  def call
    source_content_item = SourceContentItem.create!(context.params.slice(:content, :checksum))
    RenderPipeline.configuration.render_contexts.each_key do |pipeline|
      content = RenderPipeline.render(source_content_item.content, context: pipeline)
      source_content_item.rendered_content_items.create!(
        pipeline: pipeline,
        content: content,
        checksum: source_content_item.checksum
      )
      context.rendered_content = content if pipeline == context.params[:pipeline]
    end
  end
end
