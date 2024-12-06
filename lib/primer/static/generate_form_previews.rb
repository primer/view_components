# frozen_string_literal: true

# :nocov:

require "json"

module Primer
  module Static
    # :nodoc:
    module GenerateFormPreviews
      class << self
        def call
          Lookbook.previews.filter_map do |preview|
            next unless preview.preview_class == Primer::FormsPreview

            {
              name: preview.name,
              lookup_path: preview.lookup_path,
              examples: preview.scenarios.flat_map do |parent_scenario|
                scenarios = parent_scenario.type == :scenario_group ? parent_scenario.scenarios : [parent_scenario]

                scenarios.map do |scenario|
                  snapshot_tag = scenario.tags.find { |tag| tag.tag_name == "snapshot" }
                  snapshot = if snapshot_tag.nil?
                               "false"
                             elsif snapshot_tag.text.blank?
                               "true"
                             else
                               snapshot_tag.text
                             end
                  {
                    preview_path: scenario.lookup_path,
                    name: scenario.name,
                    snapshot: snapshot
                  }
                end
              end
            }
          end
        end
      end
    end
  end
end
