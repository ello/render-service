class V1::RendersController < ApplicationController

  wrap_parameters false

  before_action :ensure_pipeline_exists!

  def create
    result = RenderContent.call(params: source_content_item_params)
    if result.success?
      render html: result.rendered_content
    else
      head :unprocessable_entity
    end
  end

  private

  def source_content_item_params
    params.permit(:content, :pipeline, :checksum)
  end

  def ensure_pipeline_exists!
    params[:pipeline] = params[:pipeline].presence || 'default'
    unless RenderPipeline.configuration.render_contexts.keys.include?(params[:pipeline])
      render plain: 'Invalid pipeline specified!',
             status: :unprocessable_entity
    end
  end
end
