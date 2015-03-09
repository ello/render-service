require 'html/pipeline'
require 'rinku'
require 'gemoji'
require 'truncato'

require 'ello/render_service/filters/mention_filter'
require 'ello/render_service/filters/rumoji_filter'
require 'ello/render_service/filters/no_follow_filter'
require 'ello/render_service/filters/relative_link_filter'
require 'ello/render_service/filters/new_window_filter'
require 'ello/render_service/instrumentation'

module Ello
  module RenderService
    class MarkdownRenderer

      FILTERS = [
        Filters::MentionFilter,
        Filters::RumojiFilter,
        HTML::Pipeline::MarkdownFilter,
        HTML::Pipeline::SyntaxHighlightFilter,
        HTML::Pipeline::EmojiFilter,
        Filters::NoFollowFilter,
        Filters::RelativeLinkFilter,
        Filters::NewWindowFilter,
      ]

      CONTEXT = {
        asset_root: "//#{ENV['ASSET_HOST']}/images/",
        # base_url: root_path,
        gfm: true,
        username_pattern: /[\w\-]+/,
        username_link_cleaner_pattern: /(>@[\w\-]*?)(_{1,3}[\w\-]+_{1,3}[\w\-]*?<\/a>)/
      }

      def initialize(content)
        @content = content.presence || ''
      end

      def render(options = {})
        result = pipeline.call(clean_content)[:output].to_s
        if options[:truncate]
          tail = options[:truncate_tail] || '...'
          Truncato.truncate(result, max_length: options[:truncate], tail: tail)
        else
          result
        end
      end

      private

      def pipeline
        @pipeline ||= HTML::Pipeline.new(FILTERS, CONTEXT)
      end

      def clean_content
        @content.gsub(/\<br\>/, "\r\n").gsub(/\u00a0/, ' ').gsub(/&nbsp;/, ' ')
      end

    end
  end
end
