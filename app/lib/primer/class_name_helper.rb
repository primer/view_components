# frozen_string_literal: true

# Inspired by https://github.com/JedWatson/classnames
#
# Helps build a list of conditional class names
module Primer
  # :nodoc:
  module ClassNameHelper

    CSS_MODULES = JSON.parse(File.read(File.join(__dir__, "..", "..", "components", "primer", "primer.pcss.json"))).freeze

    def class_names(*args)
      [].tap do |classes|
        args.each do |class_name|
          case class_name
          when String
            classes << lookup_module(class_name) if class_name.present?
          when Hash
            class_name.each do |key, val|
              classes << lookup_module(key) if val
            end
          when Array
            classes << class_names(*class_name).presence
          end
        end

        classes.compact!
        classes.uniq!
      end.join(" ")
    end

    def lookup_module(class_name)
      # If class_name includes a space, split it into multiple classes and look up each one
      if class_name.include?(" ")
        class_name.split.map { |c| lookup_module(c) }.join(" ")
      else
        CSS_MODULES.fetch(class_name, class_name)
      end
    end
  end
end
