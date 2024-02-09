# frozen_string_literal: true

module Primer
  module ViewComponents
    # :nodoc:
    module FeatureFlags
      FLAGS = [
        {
          name: :primer_some_feature,
          description: "A feature flag for testing the feature flag system"
        }
      ].freeze

      class << self
        def enabled?(name)
          enabled_flags.include?(name)
        end

        def enabled_flags=(flag_names)
          enabled_flags.replace(flag_names)
        end

        def enabled_flags
          Thread.current[:__pvc_enabled_feature_flags__] ||= Set.new
        end

        def clear
          enabled_flags.clear
        end

        def all_flags
          @all_flags_override || FLAGS
        end

        # FOR TESTING ONLY

        def with_flags(all_flags_override)
          @all_flags_override = all_flags_override
          yield
        ensure
          @all_flags_override = nil
        end

        def with_enabled_flags(*flag_names)
          old_enabled_flags = enabled_flags.dup
          self.enabled_flags = flag_names
          yield
        ensure
          self.enabled_flags = old_enabled_flags
        end
      end
    end
  end

  class << self
    def feature_flags
      ViewComponents::FeatureFlags
    end
  end
end
