# frozen_string_literal: true

require "securerandom"

module Primer
  module Alpha
    class ActionList
      # :nodoc:
      class Group < Primer::Component
        attr_reader :id

        renders_one :heading, lambda { |**system_arguments|
          Heading.new(section_id: id, **system_arguments)
        }

        renders_many :items, lambda { |**system_arguments|
          @list.build_item(**system_arguments, root: nil).tap do |item|
            @list.will_add_item(item)
          end
        }

        def initialize(list:, **system_arguments)
          @list = list
          @id = "action-list-section-#{SecureRandom.uuid || system_arguments[:id]}"

          @system_arguments = system_arguments
          @system_arguments[:classes] = class_names(
            "ActionList",
            "ActionList--subGroup",
            @system_arguments[:classes]
          )
        end

        def before_render
          if heading.present?
            @system_arguments[:aria][:label] = nil
            @system_arguments[:"aria-label"] = nil
            @system_arguments[:"aria-labelledby"] = id
          else
            # aria_label = aria(:label, @system_arguments)
            # raise ArgumentError, "an aria-label is required" if aria_label.nil?
          end
        end
      end
    end
  end
end
