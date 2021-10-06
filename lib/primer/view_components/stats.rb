# frozen_string_literal: true

module Primer
  module ViewComponents
    # Class to provide stats helpers for PVC.
    class Stats
      class << self
        def accessibility_tags_count
          all_components.count do |f|
            File.read(f).include?("@accessibility")
          end
        end

        def components_count
          all_components.size
        end

        private

        def all_components
          @all_components ||= Dir[File.join(__dir__, "../../../app/components/**/*.rb")]
        end
      end
    end
  end
end
