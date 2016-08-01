require 'rails_helper'

describe 'bulk fetching posts via the API', type: :request do
  let(:content) { '### Hello, world!' }
  let(:pipeline) { 'default' }
  let(:checksum) { Digest::MD5.hexdigest(content) }

  let(:response_json) { JSON.parse(response.body) }

  describe 'when the requested content has already been rendered' do
    before do
      RenderContent.call(content: content, checksum: checksum, pipeline: pipeline)

      post '/v1/bulk_fetches',
           params: [
             { checksum: checksum,
               pipeline: pipeline },
             { checksum: checksum,
               pipeline: 'v1_bio' }
           ].to_json,
           headers: { 'Content-Type' => 'application/json' }
    end

    it 'returns a rendered form of the content' do
      expect(response_json).to eq(
        [ {
          'checksum' => checksum,
          'pipeline' => pipeline,
          'rendered_content' => '<h3>Hello, world!</h3>'
        } ]
      )
    end
  end
end
