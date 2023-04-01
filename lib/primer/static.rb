# frozen_string_literal: true

require "json"

module Primer
  # :nodoc:
  module Static
    DEFAULT_STATIC_PATH = File.expand_path("static").freeze

    FILE_NAMES = {
      statuses: "statuses.json",
      constants: "constants.json",
      audited_at: "audited_at.json",
      arguments: "arguments.json",
      previews: "previews.json",
      info_arch: "info_arch.json"
    }.freeze

    # Returns a hash mapping component names to component statuses (alpha, beta, etc),
    # sorted alphabetically by the component name.
    def self.generate_statuses
      Static::GenerateStatuses.call
    end

    # Returns a hash mapping component names to the date on which the component passed
    # an accessibility audit.
    def self.generate_audited_at
      Static::GenerateAuditedAt.call
    end

    # Returns a hash mapping component names to an array of the constants defined inside
    # the component's class.
    def self.generate_constants
      Static::GenerateConstants.call
    end

    # Returns an array of hashes, one per Primer component, that contains some metadata and
    # a list of the arguments accepted by the component's constructor. Arguments are enumerated
    # with their value, data type, and docstring.
    def self.generate_arguments
      Static::GenerateArguments.call
    end

    # Returns an array of hashes, one per Primer component, that contains some metadata and
    # an array of all the component's previews. The preview data contains the Lookbook URL
    # to each preview and its name.
    def self.generate_previews
      Static::GeneratePreviews.call
    end

    # Returns an array of hashes, one per Primer component, that contains all the data needed
    # for the new primer.style docsite.
    def self.generate_info_arch
      Static::GenerateInfoArch.call
    end

    # Generates the requested stat hash and outputs it to a file.
    def self.dump(stats)
      File.open(File.join(DEFAULT_STATIC_PATH, FILE_NAMES[stats]), "w") do |f|
        f.write(JSON.pretty_generate(send("generate_#{stats}")))
        f.write($INPUT_RECORD_SEPARATOR)
      end
    end

    # Returns the contents of the stat file.
    def self.read(stats)
      File.read(File.join(DEFAULT_STATIC_PATH, FILE_NAMES[stats]))
    end
  end
end
