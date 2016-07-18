class V1::RendersController < ApplicationController

  wrap_parameters false

  before_action :ensure_pipeline_exists!,
                :ensure_checksum_matches_content!

  def create
    result = RenderContent.call(source_content_item_params)
    if result.success?
      render json: { rendered_content: result.rendered_content }
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

  def ensure_checksum_matches_content!
    unless Digest::MD5.hexdigest(params[:content]) == params[:checksum]
      render plain: 'Checksum does not match content!',
             status: :unprocessable_entity
    end
  end
end
