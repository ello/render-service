require 'sinatra'
require 'digest/sha1'
require 'ello/render_service/markdown_renderer'

module Ello
  module RenderService
    class Application < Sinatra::Base

      if ENV['BASIC_AUTH_USERNAME'] && ENV['BASIC_AUTH_PASSWORD']
        use Rack::Auth::Basic, 'Restricted Area' do |username, password|
          username == ENV['BASIC_AUTH_USERNAME'] and password == ENV['BASIC_AUTH_PASSWORD']
        end
      end

      get '/' do
        status 200
      end

      post '/render' do
        request_body = request.body.read
        etag Digest::SHA1.hexdigest(ENV.fetch('CACHE_KEY_PREFIX') + request_body)
        cache_control :public
        rendered_content = Ello::RenderService::MarkdownRenderer.new(request_body).render
        status 200
        rendered_content
      end

    end
  end
end
