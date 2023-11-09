# frozen_string_literal: true

module Primer
  module Alpha
    class ActionMenu
      # This component is part of <%= link_to_component(Primer::Alpha::ActionMenu) %> and should not be
      # used as a standalone component.
      class List < Primer::Component
        DEFAULT_ITEM_TAG = :button
        ITEM_TAG_OPTIONS = [:a, :"clipboard-copy", DEFAULT_ITEM_TAG].freeze

        attr_reader :items

        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionMenu::List) %>
        def initialize(**system_arguments)
          @items = []
          @has_group = false

          @list = Primer::Alpha::ActionMenu::ListWrapper.new(**system_arguments)
        end

        def with_group(**system_arguments, &block)
          @has_group = true

          @items << {
            type: :group,
            kwargs: system_arguments,
            block: block
          }
        end

        def with_item(**system_arguments, &block)
          @items << {
            type: :item,
            kwargs: organize_arguments(**system_arguments),
            block: block
          }
        end

        def with_avatar_item(**system_arguments, &block)
          @items << {
            type: :avatar_item,
            kwargs: organize_arguments(**system_arguments),
            block: block
          }
        end

        def with_divider(**system_arguments, &block)
          @items << {
            type: :divider,
            kwargs: system_arguments,
            block: block
          }
        end

        private

        def contains_group?
          @has_group
        end

        def before_render
          content

          @items.each do |item|
            case item[:type]
            when :divider, :group
              add_item(item, to: @list)
            else
              if contains_group?
                @list.with_group do |group|
                  add_item(item, to: group)
                end
              else
                add_item(item, to: @list)
              end
            end
          end
        end

        def add_item(item, to:)
          parent = to
          mtd = :"with_#{item[:type]}"
          parent.send(mtd, **item[:kwargs]) do |item_instance|
            evaluate_block(item_instance, &item[:block])
          end
        end

        def organize_arguments(data: {}, **system_arguments)
          content_arguments = system_arguments.delete(:content_arguments) || {}

          # rubocop:disable Style/IfUnlessModifier
          if system_arguments[:tag] && ITEM_TAG_OPTIONS.include?(system_arguments[:tag])
            content_arguments[:tag] = system_arguments[:tag]
          end
          # rubocop:enable Style/IfUnlessModifier

          # disallow setting item's tag
          system_arguments.delete(:tag)

          # rubocop:disable Style/IfUnlessModifier
          if content_arguments[:tag] == :a
            content_arguments[:href] ||= system_arguments.delete(:href)
          end
          # rubocop:enable Style/IfUnlessModifier

          content_arguments[:tabindex] = -1
          system_arguments[:autofocus] = "" if system_arguments[:autofocus]

          content_arguments[:data] = merge_data(
            content_arguments,
            { data: { value: data.delete(:value) || system_arguments.delete(:"data-value") } }
          )

          if system_arguments[:disabled]
            content_arguments[:aria] = merge_aria(
              content_arguments,
              { aria: { disabled: true } }
            )

            system_arguments[:aria] = merge_aria(
              system_arguments,
              { aria: { disabled: true } }
            )
          end

          { data: data, **system_arguments, content_arguments: content_arguments }
        end
      end
    end
  end
end
