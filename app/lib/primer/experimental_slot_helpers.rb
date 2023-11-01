# frozen_string_literal: true

module Primer
  module ExperimentalSlotHelpers
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def add_polymorphic_slot_type(slot_name:, type:, callable:)
        slot_def = registered_slots[slot_name]
        raise "Unknown slot '#{slot_name}'" unless slot_def

        poly_def = define_slot(
          type,
          collection: slot_def[:collection],
          callable: callable
        )

        registered_slots[slot_name][:renderable_hash][type] = poly_def

        define_method(:"with_#{type}") do |**system_arguments, &block|
          set_slot(slot_name, poly_def, **system_arguments, &block)
        end
      end
    end
  end
end
