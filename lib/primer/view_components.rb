# frozen_string_literal: true

require "primer/classify"
require "primer/view_components/version"
require "primer/view_components/engine"

module Primer
  # :nodoc:
  module ViewComponents
    DEFAULT_STATIC_PATH = File.expand_path("static")
    DEFAULT_STATUS_FILE_NAME = "statuses.json"
    DEFAULT_CONSTANTS_FILE_NAME = "constants.json"

    # generate_statuses returns a hash mapping component name to
    # the component's status sorted alphabetically by the component name.
    def self.generate_statuses
      Primer::Component.descendants.sort_by(&:name).each_with_object({}) do |component, mem|
        mem[component.to_s] = component.status.to_s
      end
    end

    # dump_statuses generates the status hash and then serializes
    # it as json at the given path
    def self.dump_statuses(path: DEFAULT_STATIC_PATH)
      require "json"

      statuses = generate_statuses

      File.open(File.join(path, DEFAULT_STATUS_FILE_NAME), "w") do |f|
        f.write(JSON.pretty_generate(statuses))
        f.write($INPUT_RECORD_SEPARATOR)
      end
    end

    # read_statuses returns a JSON string matching the output of
    # generate_statuses
    def self.read_statuses(path: DEFAULT_STATIC_PATH)
      File.read(File.join(path, DEFAULT_STATUS_FILE_NAME))
    end

    # generate_constants returns a hash mapping component name to
    # all of its constants.
    def self.generate_constants
      Primer::Component.descendants.sort_by(&:name).each_with_object({}) do |component, mem|
        mem[component.to_s] = component.constants(false).each_with_object({}) do |constant, h|
          h[constant] = component.const_get(constant)
        end
      end
    end

    # dump_constants generates the constnas hash and then serializes
    # it as json at the given path
    def self.dump_constants(path: DEFAULT_STATIC_PATH)
      require "json"

      constants = generate_constants

      File.open(File.join(path, DEFAULT_CONSTANTS_FILE_NAME), "w") do |f|
        f.write(JSON.pretty_generate(constants))
        f.write($INPUT_RECORD_SEPARATOR)
      end
    end

    # read_constants returns a JSON string matching the output of
    # generate_constants
    def self.read_constants(path: DEFAULT_STATIC_PATH)
      File.read(File.join(path, DEFAULT_CONSTANTS_FILE_NAME))
    end
  end
end
