require 'html/pipeline'
require 'new_relic/agent/method_tracer'

[ HTML::Pipeline,
  Ello::RenderService::Filters::MentionFilter,
  Ello::RenderService::Filters::RumojiFilter,
  Ello::RenderService::Filters::NoFollowFilter,
  Ello::RenderService::Filters::RelativeLinkFilter,
  Ello::RenderService::Filters::NewWindowFilter,
  HTML::Pipeline::MarkdownFilter,
  HTML::Pipeline::SyntaxHighlightFilter,
  HTML::Pipeline::EmojiFilter ].each do |klass|
  klass.class_eval do
    include ::NewRelic::Agent::MethodTracer
    add_method_tracer :call
  end
end
