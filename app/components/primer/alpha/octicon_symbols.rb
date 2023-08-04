# frozen_string_literal: true

require "octicons"

module Primer
  module Alpha
    # OcticonSymbols renders a symbol dictionary using a list of <%= link_to_octicons %>.
    class OcticonSymbols < Primer::Component
      # @param icons [Array<Hash>] List of icons to render, in the format { symbol: :icon_name, size: :small }
      def initialize(icons: [])
        @icons = {}
        icons.each do |icon|
          symbol = icon[:symbol]
          size = Primer::Beta::Octicon::SIZE_MAPPINGS[
            fetch_or_fallback(Primer::Beta::Octicon::SIZE_OPTIONS, icon[:size] || Primer::Beta::Octicon::SIZE_DEFAULT, Primer::Beta::Octicon::SIZE_DEFAULT)
          ]

          cache_key = Primer::Octicon::Cache.get_key(symbol: symbol, size: size)

          if (cache_icon = Primer::Octicon::Cache.read(cache_key))
            icon_instance = cache_icon
          else
            icon_instance = Octicons::Octicon.new(symbol, height: size)

            Primer::Octicon::Cache.set(cache_key, icon_instance)
          end

          # Don't put the same icon twice
          @icons[[symbol, icon_instance.height]] = icon_instance if @icons[[symbol, icon_instance.height]].nil?
        end
      end

      def render?
        @icons.any?
      end

      def symbol_tags
        safe_join(
          @icons.values.map do |icon|
            content_tag(
              :symbol,
              icon.path.html_safe, # rubocop:disable Rails/OutputSafety
              id: "octicon_#{icon.symbol}_#{icon.height}",
              viewBox: icon.options[:viewBox],
              width: icon.width,
              height: icon.height
            )
          end
        )
      end
    end
  end
end
