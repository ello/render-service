class V1::RendersController < ApplicationController
  def create
    result = RenderContent.call(params: source_content_item_params)
    if result.success?
      render text: result.rendered_content,
             content_type: 'text/html'
    else
      head :unprocessable_entity
    end
  end

  private

  def source_content_item_params
    params.permit(:content, :pipeline, :checksum)
  end
end
