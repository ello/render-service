require 'html/pipeline'

module Ello
  module RenderService
    module Filters
      class RelativeLinkFilter < HTML::Pipeline::Filter

        include ::NewRelic::Agent::MethodTracer

        def call
          doc.search('a').each do |element|
            if element['href'] =~ /\Ahttp(s)?:\/\/(www\.)?ello.co(\/.*)/
              element['href'] = $3
            end
          end
          doc
        end

        add_method_tracer :call

      end
    end
  end
end
