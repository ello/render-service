require 'new_relic/agent/method_tracer'

RenderPipeline.configure do |config|

  config.cache = Rails.cache
  config.render_version_key = 3

  config.add_emoji 'ello'
  config.add_emoji 'nsfw_bb'
  config.add_emoji 'nsfw_gb'
  config.add_emoji 'nsfw_gg'
  config.add_emoji 'berger_fohr'
  config.add_emoji 'budnitz_bicycles'
  config.add_emoji 'mode_set'
  config.add_emoji 'llama'
  config.add_emoji 'prosper'
  config.add_emoji 'doge'
  config.add_emoji 'ello_smiley'
  config.add_emoji 'kim_jong_un'
  config.add_emoji 'pride'
  config.add_emoji 'hot_shit'

  config.render_context :default do |c|
    c.asset_root = "#{HostConfiguration::AssetHostConfiguration.call}/images/"
    c.host_name = ENV['ACTIONMAILER_DEFAULT_HOST']
    c.hashtag_root = '/search'
    c.render_filters = RenderPipeline.configuration.render_filters - [RenderPipeline::Filter::ImageAdjustments]
  end

  config.render_context :with_image_adjustments do |c|
    c.render_filters = RenderPipeline.configuration.render_filters + [RenderPipeline::Filter::ImageAdjustments]
  end

  config.render_context :notification_email do |c|
    c.use_absolute_url = true
    c.asset_root = "#{HostConfiguration::AssetHostConfiguration.call}/images/"
    c.host_name = ENV['ACTIONMAILER_DEFAULT_HOST']
    c.hashtag_root = '/search'
    c.render_filters = RenderPipeline.configuration.render_filters - [RenderPipeline::Filter::ImageAdjustments]
  end
end

[ HTML::Pipeline, RenderPipeline.configuration.render_filters ].flatten.each do |klass|
  klass.class_eval do
    include ::NewRelic::Agent::MethodTracer
    add_method_tracer :call
  end
end
