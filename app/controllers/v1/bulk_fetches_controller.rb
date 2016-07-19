class V1::BulkFetchesController < ApplicationController

  wrap_parameters false

  def create
    result = RenderedContentItem.matching_checksums_and_pipelines(params['_json']).map do |item|
      {
        rendered_content: item.content,
        checksum:         item.checksum,
        pipeline:         item.pipeline
      }
    end
    render json: result.to_json
  end

end
