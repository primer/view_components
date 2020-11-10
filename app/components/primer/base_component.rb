# frozen_string_literal: true

module Primer
  # All Primer ViewComponents accept a standard set of options called System Arguments, mimicking the [styled-system API](https://styled-system.com/table) [used by Primer React](https://primer.style/components/system-props).
  #
  # Under the hood, System Arguments are [mapped](https://github.com/primer/view_components/blob/main/lib/primer/classify.rb) to Primer CSS classes, with any remaining options passed to Rails' [`content_tag`](https://api.rubyonrails.org/classes/ActionView/Helpers/TagHelper.html#method-i-content_tag).
  #
  # ## Responsive values
  #
  # To apply different values across responsive breakpoints, pass an array with up to five values in the order `[default, small, medium, large, xlarge]`. To skip a breakpoint, pass `nil`.
  #
  # For example:
  #
  # ```erb
  # <%= render Primer::HeadingComponent.new(mt: [0, nil, nil, 4, 2]) do %>
  #   Hello world
  # <% end %>
  # ```
  #
  # Renders:
  #
  # ```html
  # <h1 class="mt-0 mt-lg-4 mt-xl-2">Hello world</h1>
  # ```
  #
  class BaseComponent < Primer::Component
    TEST_SELECTOR_TAG = :test_selector

    # @param m [Integer] Margin. <%= one_of((-6..6).to_a) %>
    # @param mt [Integer] Margin left. <%= one_of((-6..6).to_a) %>
    # @param mr [Integer] Margin right. <%= one_of((-6..6).to_a) %>
    # @param mb [Integer] Margin bottom. <%= one_of((-6..6).to_a) %>
    # @param ml [Integer] Margin left. <%= one_of((-6..6).to_a) %>
    # @param mx [Integer] Horizontal margins. <%= one_of((-6..6).to_a + [:auto]) %>
    # @param my [Integer] Vertical margins. <%= one_of((-6..6).to_a) %>
    # @param m [Integer] Padding. <%= one_of((0..6).to_a) %>
    # @param mt [Integer] Padding left. <%= one_of((0..6).to_a) %>
    # @param mr [Integer] Padding right. <%= one_of((0..6).to_a) %>
    # @param mb [Integer] Padding bottom. <%= one_of((0..6).to_a) %>
    # @param ml [Integer] Padding left. <%= one_of((0..6).to_a) %>
    # @param mx [Integer] Horizontal padding. <%= one_of((0..6).to_a) %>
    # @param my [Integer] Vertical padding. <%= one_of((0..6).to_a) %>
    #
    # @param position [Symbol] <%= one_of([:relative, :absolute, :fixed]) %>
    #
    # @param top [Boolean] If `false`, sets `top: 0`.
    # @param right [Boolean] If `false`, sets `right: 0`.
    # @param bottom [Boolean] If `false`, sets `bottom: 0`.
    # @param left [Boolean] If `false`, sets `left: 0`.
    #
    # @param display [Symbol] <%= one_of([:block, :none, :inline, :inline_block, :table, :table_cell]) %>
    #
    # @param hide [Symbol] Hide the element at a specific breakpoint. <%= one_of([:sm, :md, :lg, :xl]) %>
    #
    # @param vertical_align [Symbol] <%= one_of([:baseline, :top, :middle, :bottom, :text_top, :text_bottom]) %>
    #
    # @param float [Symbol] <%= one_of([:left, :right]) %>
    #
    # @param font_size [String] <%= one_of(["00", "0", "1", "2", "3", "4", "5", "6"]) %>
    # @param tag [Symbol] HTML tag name to be passed to `tag.send`
    # @param classes [String] CSS class name value to be concatenated with generated Primer CSS classes
    def initialize(tag:, classes: nil, **system_arguments)
      @tag = tag
      @result = Primer::Classify.call(**system_arguments.merge(classes: classes))

      # Filter out Primer keys so they don't get assigned as HTML attributes
      @content_tag_args = add_test_selector(system_arguments).except(*Primer::Classify::VALID_KEYS)
    end

    def call
      content_tag(@tag, content, **@content_tag_args.merge(@result))
    end

    private

    def add_test_selector(args)
      if args.key?(TEST_SELECTOR_TAG) && !Rails.env.production?
        args[:data] ||= {}
        args[:data][TEST_SELECTOR_TAG] = args[TEST_SELECTOR_TAG]
      end

      args.except(TEST_SELECTOR_TAG)
    end
  end
end
