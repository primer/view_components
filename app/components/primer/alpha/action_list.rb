# frozen_string_literal: true

module Primer
  module Alpha
    # :nodoc:
    class ActionList < Primer::Component
      renders_many :items, lambda { |**system_arguments|
        build_item(**system_arguments, is_sub_item: false, root: nil).tap do |item|
          will_add_item(item)
        end
      }

      renders_many :sections, lambda { |**system_arguments|
        build_section(**system_arguments)
      }

      def initialize(tag: :ul, role: :list, item_classes: nil, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = tag

        @list_arguments = {
          role: role
        }

        @item_classes = item_classes
      end

      def build_item(**system_arguments)
        system_arguments[:classes] = class_names(
          @item_classes,
          system_arguments[:classes]
        )

        ActionList::Item.new(list: self, **system_arguments)
      end

      def build_section(**system_arguments)
        ActionList::Section.new(list: self, **system_arguments)
      end

      def will_add_item(_item); end
      def will_add_section(_section); end
    end
  end
end
