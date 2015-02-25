require 'spec_helper'

describe 'The renderer app' do

  def app
    Ello::RenderService::Application
  end

  it 'says hello' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'renders content posted to /render' do
    post '/render', '# Hello'
    expect(last_response.body).to eq('<h1>Hello</h1>')
  end

end
