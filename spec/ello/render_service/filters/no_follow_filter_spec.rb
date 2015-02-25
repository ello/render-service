require 'spec_helper'

describe Ello::RenderService::Filters::NoFollowFilter do

  let(:html) { '<a href="http://www.ello.co/">Ello!</a>'}
  let(:result) { described_class.to_html(html) }

  it 'adds rel=nofollow to links' do
    expect(result).to eq('<a href="http://www.ello.co/" rel="nofollow">Ello!</a>')
  end

end
