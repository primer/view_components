# frozen_string_literal: true

require "test_helper"

class Primer::CacheableTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class CachedComponent < ViewComponent::Base
    include Primer::Cacheable

    def initialize(*args)
      @delegate = Primer::OcticonComponent.new(*args)
    end

    def call
      render @delegate
    end

    def self.cache_container
      @cache_container ||= {}
    end
  end

  def test_renders_the_same_content_without_caching
    view_context = controller.view_context

    original = Primer::OcticonComponent.new(icon: :smiley, height: 18, classes: "social-button-emoji").render_in(view_context)
    cached = CachedComponent.with(icon: :smiley, height: 18, classes: "social-button-emoji").render_in(view_context)
    cached_again = CachedComponent.with(icon: :smiley, height: 18, classes: "social-button-emoji").render_in(view_context)

    assert_equal original, cached
    assert_equal cached, cached_again
  end

  def test_returns_the_same_object_when_passed_the_same_arguments
    cached = CachedComponent.with(icon: :smiley, height: 18, classes: "social-button-emoji")
    cached_again = CachedComponent.with(icon: :smiley, height: 18, classes: "social-button-emoji")
    cached_with_different_arguments = CachedComponent.with(icon: :smiley, height: 14, classes: "social-button-emoji")

    assert_equal cached.object_id, cached_again.object_id
    refute_equal cached_with_different_arguments.object_id, cached.object_id
  end

  # Test documentation example
  class Current < ActiveSupport::CurrentAttributes
    attribute :primer_cache
  end

  class DocumentationExample
    include Primer::Cacheable

    def initialize(value)
      @value = value
    end

    def self.cache_container
      Current.primer_cache ||= {}
      Current.primer_cache[name] ||= {}
    end
  end

  def test_doc_example
    cached = DocumentationExample.with(icon: :smiley, height: 18, classes: "social-button-emoji")
    cached_again = DocumentationExample.with(icon: :smiley, height: 18, classes: "social-button-emoji")
    cached_with_different_arguments = DocumentationExample.with(icon: :smiley, height: 14, classes: "social-button-emoji")

    assert_equal cached.object_id, cached_again.object_id
    refute_equal cached_with_different_arguments.object_id, cached.object_id
  end
end
