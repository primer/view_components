# frozen_string_literal: true

# Inspired by https://github.com/JedWatson/classnames
#
# Helps build a list of conditional class names
module Primer
  module ClassNameHelper
    def class_names(*args)
      classes = []

      args.each do |class_name|
        case class_name
        when String
          classes << class_name if class_name != ""
        when Hash
          class_name.each do |key, val|
            classes << key if val
          end
        when Array
          aux = class_names(*class_name)
          classes << class_names(*class_name) if aux != ""
        end
      end

      classes.compact.uniq.join(" ")
    end
  end
end
