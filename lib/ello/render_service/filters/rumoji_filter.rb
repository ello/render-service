require 'html/pipeline'
require 'rumoji'

module Ello
  module RenderService
    module Filters
      class RumojiFilter < HTML::Pipeline::TextFilter

        UNICODE_EMOJI_REGEX = /[\u{2194}-\u{1F6FF}]/

        include ::NewRelic::Agent::MethodTracer

        def call
          if UNICODE_EMOJI_REGEX.match(@text)
            Rumoji.encode(@text)
          else
            @text
          end
        end

        add_method_tracer :call

      end
    end
  end
end
