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

  common_config = lambda do |c|
    c.truncate_tail = '...'
    c.asset_root = "#{ENV['ASSET_HOST_WITH_PROTOCOL']}/images/"
    c.host_name = ENV['ACTIONMAILER_DEFAULT_HOST']
    c.hashtag_root = '/search'
  end

  config.render_context :default, :v1_content do |c|
    common_config.call(c)
  end

  config.render_context :v1_bio do |c|
    c.truncate_length = 666
    common_config.call(c)
  end

  config.render_context :v1_summary_120 do |c|
    c.truncate_length = 120
    common_config.call(c)
  end

  config.render_context :v1_summary_160 do |c|
    c.truncate_length = 160
    common_config.call(c)
  end

  config.render_context :notification_email do |c|
    c.truncate_length = 50
    c.use_absolute_url = true
    common_config.call(c)
  end
end

[ HTML::Pipeline, RenderPipeline.configuration.render_filters ].flatten.each do |klass|
  klass.class_eval do
    include ::NewRelic::Agent::MethodTracer
    add_method_tracer :call
  end
end
