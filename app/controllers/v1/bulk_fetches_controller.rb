class V1::BulkFetchesController < ApplicationController

  wrap_parameters false

  def create
    result = params['_json'].map do |r|
      if item = RenderedContentItem.where(checksum: r['checksum'],
                                          pipeline: r['pipeline']).first
        {
          rendered_content: item.content,
          checksum:         item.checksum,
          pipeline:         item.pipeline
        }
      end
    end
    render json: result.compact.to_json
  end

end
