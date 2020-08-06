# frozen_string_literal: true

module Primer
  # Base component used by other Primer components.
  #
  # tag(symbol): HTML tag name to be passed to tag.send(tag)
  # class_names(string): CSS class name value to be concatenated with generated Primer CSS classes
  # args(hash): Combination of arguments for classes_from_hash and content_tag
  #
  # Example usage:
  # <%= render Primer::BaseComponent, tag: :a, href: "http://www.google.com", mt: 4 do %>Link<% end %>
  # generates:
  # <a href="http://www.google.com" class="mt-4">Link</a>
  class BaseComponent < Primer::Component
    TEST_SELECTOR_TAG = :test_selector

    def initialize(tag:, classes: nil, **args)
      @tag = tag
      @classes = Primer::Classify.call(**args.merge(classes: classes))

      # Filter out Primer keys so they don't get assigned as HTML attributes
      @content_tag_args = add_test_selector(args).except(*Primer::Classify::VALID_KEYS)
    end

    def call
      tag.public_send(@tag, content, **{ class: @classes }.merge(@content_tag_args))
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
