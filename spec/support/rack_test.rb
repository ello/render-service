require 'rspec'
require 'rack/test'

RSpec.configure do |c|
  c.include Rack::Test::Methods
end
