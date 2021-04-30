# frozen_string_literal: true

require "octicons"

module Primer
  # OcticonSymbol renders a symbol dictionary using a list of <%= link_to_octicons %>.
  class OcticonSymbolComponent < Primer::Component
    # Required list of icons. These will be the icons that are rendered.
    #
    # @param symbol [String] Name of <%= link_to_octicons %> to use.
    # @param size [Symbol] <%= one_of(Primer::OcticonComponent::SIZE_MAPPINGS) %>
    renders_many :icons, "Symbol"

    # @example Symbol dictionary
    #   <%= render(Primer::OcticonComponent.new(icon: :check, use_symbol: true, color: :icon_success)) %>
    #   <%= render(Primer::OcticonComponent.new(icon: :check, use_symbol: true, color: :text_danger)) %>
    #   <%= render(Primer::OcticonComponent.new(icon: :check, use_symbol: true, size: :medium)) %>
    #   <%= render(Primer::OcticonSymbolComponent.new) do |c| %>
    #     <%= c.icon(symbol: :check) %>
    #     <%= c.icon(symbol: :check, size: :medium) %>
    #   <% end %>
    def initialize
      super
    end

    def before_render
      # Make sure we don't have any duplicate icons
      icons.uniq! { |icon| "#{icon.icon.symbol}#{icon.icon.height}" }
    end

    def render?
      icons.any?
    end

    # This component is part of `Primer::OcticonSymbolComponent` and should not be
    # used as a standalone component.
    class Symbol < Primer::Component
      attr_reader :icon

      def initialize(symbol:, size: Primer::OcticonComponent::SIZE_DEFAULT)
        cache_key = Primer::Octicon::Cache.get_key(symbol: symbol, size: size)

        if (cache_icon = Primer::Octicon::Cache.read(cache_key))
          @icon = cache_icon
        else
          @icon = Octicons::Octicon.new(symbol, height: Primer::OcticonComponent::SIZE_MAPPINGS[fetch_or_fallback(Primer::OcticonComponent::SIZE_OPTIONS, size, Primer::OcticonComponent::SIZE_DEFAULT)])
          Primer::Octicon::Cache.set(cache_key, @icon)
        end

        @system_arguments = {
          tag: :symbol,
          id: "octicon-#{@icon.symbol}-#{@icon.height}",
          viewBox: @icon.options[:viewBox],
          width: @icon.width,
          height: @icon.height
        }
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { @icon.path.html_safe } # rubocop:disable Rails/OutputSafety
      end
    end

    Primer::Octicon::Cache.preload!
  end
end
