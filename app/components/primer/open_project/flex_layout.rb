# frozen_string_literal: true

module Primer
  module OpenProject
    # A layouting component used to arrange multiple components next / below each other
    class FlexLayout < Primer::Component
      status :open_project

      renders_many :rows, lambda { |**system_arguments, &block|
        child_component(system_arguments, &block)
      }
      renders_many :columns, lambda { |**system_arguments, &block|
        child_component(system_arguments, &block)
      }
      # boxes are used when direction is set to row or column based on responsive breakpoints
      renders_many :boxes, lambda { |**system_arguments, &block|
        child_component(system_arguments, &block)
      }

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        super

        @system_arguments = deny_tag_argument(**system_arguments) || {}
        @system_arguments[:display] = :flex
      end

      private

      def render?
        # no slot provided
        raise ArgumentError, "You have to provide either rows, columns or boxes as a slot" if rows.empty? && columns.empty? && boxes.empty?

        if [rows, columns, boxes].count { |arr| !arr.empty? } == 1
          # only rows or columns or boxes are used
          true
        elsif [rows, columns, boxes].count { |arr| !arr.empty? } > 1
          # rows, columns and boxes are used together, which is not allowed
          raise ArgumentError, "You can't mix row, column and box slots"
        end
      end

      def child_component(system_arguments, &block)
        if system_arguments[:flex_layout] == true
          Primer::OpenProject::FlexLayout.new(**system_arguments.except(:flex_layout), &block)
        else
          Primer::Box.new(**system_arguments || {})
        end
      end
    end
  end
end
