# frozen_string_literal: true

require "test_helper"

class AllComponentsHaveStoriesTest < Minitest::Test
  EXCLUDED_COMPONENTS = [
    Primer::BaseComponent,
    Primer::FlexItemComponent,
    Primer::OcticonSymbolsComponent
  ].freeze

  COMPONENTS = Primer::Component.descendants - EXCLUDED_COMPONENTS

  def test_all_components_have_stories
    components_without_stories = []

    COMPONENTS.each do |component|
      check_for_stories(component, components_without_stories)
    end

    assert components_without_stories.empty?, "The following components have no storybook stories defined: #{components_without_stories.map(&:name).join(', ')}. Please tell a story."
  end

  private

  def check_for_stories(component, missing_accumulator)
    components_with_stories_names = Dir.glob("stories/**/*.rb").map do |path|
      path[15, path.size].chomp("_stories.rb")
    end

    component_name = component.to_s.sub("Primer::", "").underscore

    return if components_with_stories_names.include?(component_name)

    missing_accumulator << component
  end
end
