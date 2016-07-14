require 'rails_helper'

describe 'rendering a post via the API', type: :request do
  let(:content) { '### Hello, world!' }
  let(:pipeline) { 'default' }
  let(:checksum) { Digest::SHA1.hexdigest(content) }

  it 'returns a rendered form of the content' do
    post '/v1/render',
         params: {
           checksum: checksum,
           pipeline: pipeline,
           content: content
         }.to_json,
         headers: { 'Content-Type' => 'application/json' }
    expect(response.body).to eq('<h3>Hello, world!</h3>')
  end
end
