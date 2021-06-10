# frozen_string_literal: true

require_relative "helpers"
require_relative "argument_mappers/button"
require "pry"

module ERBLint
  module Linters
    # Counts the number of times a HTML button is used instead of the component.
    class ButtonComponentMigrationCounter < Linter
      include Helpers

      TAGS = %w[button summary a].freeze
      CLASSES = %w[btn btn-link].freeze
      MESSAGE = "We are migrating buttons to use [Primer::ButtonComponent](https://primer.style/view-components/components/button), please try to use that instead of raw HTML."

      def run(processed_source)
        tags = tags(processed_source)
        tag_tree = build_tag_tree(tags)

        tags.each do |tag|
          next if tag.closing?
          next unless self.class::TAGS&.include?(tag.name)

          classes = tag.attributes["class"]&.value&.split(" ") || []

          tag_tree[tag][:offense] = false

          next unless self.class::CLASSES.blank? || (classes & self.class::CLASSES).any?

          args = map_arguments(tag)

          tag_tree[tag][:offense] = true
          tag_tree[tag][:correctable] = args.present?
          tag_tree[tag][:message] = message(args)
          tag_tree[tag][:correction] = correction(args)
        end

        tag_tree.each do |tag, err|
          next unless err[:offense] && err[:correctable]

          add_offense(tag.loc, err[:message], err[:correction])
          add_offense(err[:closing].loc, err[:message], "<% end %>")
        end

        counter_correct?(processed_source)
      end

      private

      def map_arguments(tag)
        ArgumentMappers::Button.new(tag).to_s
      rescue ArgumentMappers::ConversionError
        nil
      end

      def correction(args)
        correction = "<%= render Primer::ButtonComponent.new"
        correction += "(#{args})" if args.present?
        "#{correction} do %>"
      end

      def message(args)
        return MESSAGE if args.nil?

        "#{MESSAGE}\n\nTry using:\n\n#{correction(args)}\n\nInstead of:\n"
      end
    end
  end
end
