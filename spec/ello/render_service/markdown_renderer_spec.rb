require 'spec_helper'

describe Ello::RenderService::MarkdownRenderer do
  it 'should convert @ mentions to links' do
    html = described_class.new('<div>@username</div>').render
    expect(html).to eq('<div><a href="/username" class="user-mention" rel="nofollow">@username</a></div>')
  end

  it 'should convert @ mentions to links when the username starts with a dash' do
    html = described_class.new('<div>@-username</div>').render
    expect(html).to eq('<div><a href="/-username" class="user-mention" rel="nofollow">@-username</a></div>')
  end

  it 'should convert @ mentions to links when the username starts with an underscore' do
    html = described_class.new('<div>@_username</div>').render
    expect(html).to eq('<div><a href="/_username" class="user-mention" rel="nofollow">@_username</a></div>')
  end

  it 'should convert @ mentions to links when the username has a hyphen in it' do
    html = described_class.new('<div>@user-name</div>').render
    expect(html).to eq('<div><a href="/user-name" class="user-mention" rel="nofollow">@user-name</a></div>')
  end

  it 'should convert @ mentions to links when the username has an underscore in it' do
    html = described_class.new('<div>@user_name</div>').render
    expect(html).to eq('<div><a href="/user_name" class="user-mention" rel="nofollow">@user_name</a></div>')
  end

  it 'converts unicode emoji into their image equivalents' do
    html = described_class.new("\xF0\x9F\x98\x81").render
    expect(html).to eq("<p><img class=\"emoji\" title=\":grin:\" alt=\":grin:\" src=\"//#{ENV['ASSET_HOST']}/images/emoji/unicode/1f601.png\" height=\"20\" width=\"20\" align=\"absmiddle\"></p>")
  end
end
