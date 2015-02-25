require 'spec_helper'

describe Ello::RenderService::Filters::RelativeLinkFilter do

  let(:html) { '<a href="https://ello.co/thomashawk/posts/1">Post</a>' }
  let(:result) { described_class.to_html(html) }

  it 'strips the protocol and host from the link' do
    expect(result).to eq('<a href="/thomashawk/posts/1">Post</a>')
  end

  describe 'when a link is not to ello' do
    let(:html) { '<a href="http://www.example.com/test">Test</a>' }

    it 'does not strip the protocol and host' do
      expect(result).to eq('<a href="http://www.example.com/test">Test</a>')
    end
  end
end
