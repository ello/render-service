require 'spec_helper'

describe Ello::RenderService::Filters::NewWindowFilter do

  let(:html) { '<a href="http://www.ello.co/">Ello!</a>'}
  let(:result) { described_class.to_html(html) }

  it 'adds a blank target attribute to links' do
    expect(result).to eq('<a href="http://www.ello.co/" target="_blank">Ello!</a>')
  end

  describe 'when a link is relative' do
    let(:html) { '<a href="/friends">Ello!</a>'}

    it 'does not add a target attribute' do
      expect(result).to eq('<a href="/friends">Ello!</a>')
    end
  end
end
