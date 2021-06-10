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
        aux = {}
        curr = nil

        tags(processed_source).each do |tag|
          next unless self.class::TAGS&.include?(tag.name)

          if tag.closing?
            if curr && tag.name == curr.name
              aux[curr][:closing] = tag
              curr = aux[curr][:parent]
            end

            next
          end

          classes = tag.attributes["class"]&.value&.split(" ") || []

          aux[tag] = {
            offense: false,
            closing: nil,
            parent: curr
          }

          if self.class::CLASSES.blank? || (classes & self.class::CLASSES).any?
            args = map_arguments(tag)

            aux[tag][:offense] = true
            aux[tag][:args] = args
            aux[tag][:message] = message(args)
            aux[tag][:correction] = correction(args)
          end

          curr = tag
        end

        aux.each do |tag, err|
          next if !err[:offense] || err[:args].nil?

          add_offense(tag.loc, err[:message], err[:correction])
          add_offense(err[:closing].loc, err[:message], "<% end %>")
        end

        # counter_correct?(processed_source)
      end

      def autocorrect(_, offense)
        return unless offense.context

        lambda do |corrector|
          # if processed_source.file_content.include?("erblint:counter #{self.class.name.demodulize}")
          #   # update the counter if exists
          corrector.replace(offense.source_range, offense.context)
          # else
          #   # add comment with counter if none
          #   corrector.insert_before(processed_source.source_buffer.source_range, "#{offense.context}\n")
          # end
        end
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
