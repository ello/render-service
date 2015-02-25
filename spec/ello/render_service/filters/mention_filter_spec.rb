require 'spec_helper'

describe Ello::RenderService::Filters::MentionFilter do

  def get_result(html)
    described_class.to_html(html, Ello::RenderService::MarkdownRenderer::CONTEXT)
  end

  it 'returns a string with links embedded in it for usernames' do
    html = 'this is a test comment @test'

    result = get_result(html)

    expect(result).to be_a String
    expect(result).to include 'href="/test"'
  end

  it 'updates usernames surrounded by underscores to work with markdown' do
    html = 'this is a test comment @_test_'
    result = get_result(html)
    expect(result).to include '@\_test_'
  end

  it 'updates usernames surrounded by multiple underscores to work with markdown' do
    html = 'this is a test comment @__test__'
    result = get_result(html)
    expect(result).to include '@\__test__'
  end

  it 'updates usernames surrounded by an unevent number of underscores to work with markdown' do
    html = 'this is a test comment @___test______'
    result = get_result(html)
    expect(result).to include '@\___test______'
  end

  it 'updates usernames surrounded by an uneven number of underscores with more in group two to work with markdown' do
    html = 'this is a test comment @_te_st______'
    result = get_result(html)
    expect(result).to include '@\_te_st______'
  end

  it 'updates usernames surrounded by underscores but preceeded by other stuff to work with markdown' do
    html = 'this is a test comment @-___test______test'
    result = get_result(html)
    expect(result).to include '@-\___test______test'
  end

  it 'does not modify usernames that only start with underscores' do
    html = 'this is a test comment @_test'
    result = get_result(html)
    expect(result).to include '@_test'
  end

  it 'does not modify usernames that only end with underscores' do
    html = 'this is a test comment @test_'
    result = get_result(html)
    expect(result).to include '@test_'
  end

  it 'cannot run after the HTML doc attribute has been set in the pipeline' do
    doc = Nokogiri::XML::DocumentFragment.parse('<div>this is a test comment @test_</div>')
    filter = described_class.new(doc, Ello::RenderService::MarkdownRenderer::CONTEXT)
    expect { filter.call }.to raise_error(TypeError, 'Mention filter must run before HTML document is set')
  end

end
