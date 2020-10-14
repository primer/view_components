# frozen_string_literal: true

module Primer
  # Base component used by other Primer components.
  class BaseComponent < Primer::Component
    TEST_SELECTOR_TAG = :test_selector

    #
    # @example Default
    #   <%= render(Primer::BaseComponent.new(tag: :a, href: "http://www.google.com", mt: 4)) { "Link" } %>
    #
    # @param tag [Symbol] HTML tag name to be passed to tag.send(tag)
    # @param classes [String] CSS class name value to be concatenated with generated Primer CSS classes
    def initialize(tag:, classes: nil, **args)
      @tag = tag
      @result = Primer::Classify.call(**args.merge(classes: classes))

      # Filter out Primer keys so they don't get assigned as HTML attributes
      @content_tag_args = add_test_selector(args).except(*Primer::Classify::VALID_KEYS)
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
