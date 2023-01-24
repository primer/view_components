# frozen_string_literal: true

require "primer/classify"
require "primer/view_components/version"
require "primer/view_components/engine"

module Primer
  # :nodoc:
  module ViewComponents
    DEFAULT_STATIC_PATH = File.expand_path("static")
    FILE_NAMES = {
      statuses: "statuses.json",
      constants: "constants.json",
      audited_at: "audited_at.json"
    }.freeze

    # generate_statuses returns a hash mapping component name to
    # the component's status sorted alphabetically by the component name.
    def self.generate_statuses
      Primer::Component.descendants.sort_by(&:name).each_with_object({}) do |component, mem|
        mem[component.to_s] = component.status.to_s
      end
    end

    # generate_audited_at returns a hash mapping component name to
    # the day the component has passed an accessibility audit.
    def self.generate_audited_at
      Primer::Component.descendants.sort_by(&:name).each_with_object({}) do |component, mem|
        mem[component.to_s] = component.audited_at.to_s
      end
    end

    # generate_constants returns a hash mapping component name to
    # all of its constants.
    def self.generate_constants
      Primer::Component.descendants.sort_by(&:name).each_with_object({}) do |component, mem|
        mem[component.to_s] = component.constants(false).sort.each_with_object({}) do |constant, h|
          h[constant] = component.const_get(constant)
        end
      end
    end

    # dump generates the requested stat hash and outputs it to a file.
    def self.dump(stats)
      require "json"

      File.open(File.join(DEFAULT_STATIC_PATH, FILE_NAMES[stats]), "w") do |f|
        f.write(JSON.pretty_generate(send("generate_#{stats}")))
        f.write($INPUT_RECORD_SEPARATOR)
      end
    end

    # read returns a JSON string matching the output of the corresponding stat.
    def self.read(stats)
      File.read(File.join(DEFAULT_STATIC_PATH, FILE_NAMES[stats]))
    end

    # primer/view_components root directory.
    def self.root
      Pathname(File.expand_path(File.join("..", ".."), __dir__))
    end
  end
end
