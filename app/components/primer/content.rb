# frozen_string_literal: true

module Primer
  # Use `Content` as a helper to render content passed to a slot without adding any tags.
  class Content < Primer::Component
    status :stable

    def call
      content
    end
  end
end
