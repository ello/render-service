require 'html/pipeline'

module Ello
  module RenderService
    module Filters
      class NewWindowFilter < HTML::Pipeline::Filter

        include ::NewRelic::Agent::MethodTracer

        def call
          doc.search('a').each do |element|
            unless element['href'] =~ /\A\//
              element['target'] = '_blank'
            end
          end
          doc
        end

        add_method_tracer :call

      end
    end
  end
end
