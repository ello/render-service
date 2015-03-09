require 'rubygems'
require 'bundler'

Bundler.setup

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'ello/render_service'

# Set timeouts
require 'rack-timeout'
Rack::Timeout.timeout = 20  # seconds
use Rack::Timeout

# Cache in memcache
require 'dalli'
require 'rack/cache'
cache = if ENV['MEMCACHIER_SERVERS']
          Dalli::Client.new((ENV['MEMCACHIER_SERVERS'] || '').split(','),
                            username: ENV["MEMCACHIER_USERNAME"],
                            password: ENV["MEMCACHIER_PASSWORD"],
                            failover: true,
                            socket_timeout: 1.5,
                            socket_failure_delay: 0.2)
        else
          Dalli::Client.new
        end
use Rack::Cache,
    verbose: true,
    metastore: cache,
    entitystore: cache

# Run the actual app
run Ello::RenderService::Application
