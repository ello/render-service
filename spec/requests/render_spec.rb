require 'rails_helper'

describe 'rendering a post via the API', type: :request do
  let(:content) { '### Hello, world!' }
  let(:pipeline) { 'default' }
  let(:checksum) { Digest::MD5.hexdigest(content) }
  let(:response_json) { JSON.parse(response.body) }

  before do
    post '/v1/render',
         params: {
           checksum: checksum,
           pipeline: pipeline,
           content: content
         }.to_json,
         headers: { 'Content-Type' => 'application/json' }
  end

  it 'returns a rendered form of the content' do
    expect(response_json).to eq('rendered_content' => '<h3>Hello, world!</h3>')
  end

  describe 'when no pipeline is specified' do
    let(:pipeline) { nil }

    it 'renders with the default pipeline' do
      expect(response_json).to eq('rendered_content' => '<h3>Hello, world!</h3>')
    end
  end

  describe 'when an invalid pipeline is supplied' do
    let(:pipeline) { 'noop' }

    it 'returns back a 422' do
      expect(response.status).to eq(422)
    end
  end
end
