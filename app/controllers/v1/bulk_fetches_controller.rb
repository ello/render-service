class V1::BulkFetchesController < ApplicationController

  wrap_parameters false

  before_action :short_circuit_empty_arrays 

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

  private

  def short_circuit_empty_arrays
    render json: [].to_json if params['_json'].empty?
  end

end
