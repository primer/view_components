# frozen_string_literal: true

module Primer
  # :nodoc:
  module Forms
    # :nodoc:
    module Utils
      # Unfortunately this bug (https://github.com/ruby/ruby/pull/5646) prevents us from using
      # Ruby's native Module.const_source_location. Instead we have to fudge it by searching
      # for the file in the configured autoload paths. Doing so relies on Rails' autoloading
      # conventions, so it should work ok. Zeitwerk also has this information but lacks a
      # public API to map constants to source files.
      def const_source_location(class_name)
        # NOTE: underscore respects namespacing, i.e. will convert Foo::Bar to foo/bar.
        class_path = "#{class_name.underscore}.rb"

        ActiveSupport::Dependencies.autoload_paths.each do |autoload_path|
          absolute_path = File.join(autoload_path, class_path)
          return absolute_path if File.exist?(absolute_path)
        end

        nil
      end
    end

    Utils.extend(Utils)
  end
end
