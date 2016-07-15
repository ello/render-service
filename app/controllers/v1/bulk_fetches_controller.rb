class V1::BulkFetchesController < ApplicationController

  wrap_parameters false

  def create
    result = params['_json'].map do |r|
      item = RenderedContentItem.where(checksum: r['checksum'],
                                       pipeline: r['pipeline']).first
      { rendered_content: item && item.content }
    end
    render json: result.to_json
  end

end
