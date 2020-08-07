# frozen_string_literal: true

# Inspired by https://github.com/JedWatson/classnames
#
# Helps build a list of conditional class names
module Primer
  module ClassNameHelper
    include Unloadable

    def class_names(*args)
      classes = []

      args.each do |class_name|
        case class_name
        when String
          classes << class_name if class_name.present?
        when Hash
          class_name.each do |key, val|
            classes << key if val
          end
        when Array
          classes << class_names(*class_name).presence
        end
      end

      classes.compact.uniq.join(" ")
    end
  end
end
