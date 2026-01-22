# frozen_string_literal: true

module Primer
  module Alpha
    # @label Stack
    class StackPreview < ViewComponent::Preview
      # @label Default
      def default
        render(Primer::Alpha::Stack.new(border: true, border_color: :success_emphasis)) do
          "Hello, world!"
        end
      end

      # @label Gap options
      # @snapshot
      def gap_options
        render_with_template
      end

      # @label Playground
      #
      # @param tag text
      # @param justify [Symbol] select {{ Primer::Alpha::Stack::JustifyArg::OPTIONS }}
      # @param justify_narrow [Symbol] select {{ Primer::Alpha::Stack::JustifyArg::OPTIONS }}
      # @param justify_regular [Symbol] select {{ Primer::Alpha::Stack::JustifyArg::OPTIONS }}
      # @param justify_wide [Symbol] select {{ Primer::Alpha::Stack::JustifyArg::OPTIONS }}
      # @param gap [Symbol] select {{ Primer::Alpha::Stack::GapArg::OPTIONS }}
      # @param gap_narrow [Symbol] select {{ Primer::Alpha::Stack::GapArg::OPTIONS }}
      # @param gap_regular [Symbol] select {{ Primer::Alpha::Stack::GapArg::OPTIONS }}
      # @param gap_wide [Symbol] select {{ Primer::Alpha::Stack::GapArg::OPTIONS }}
      # @param direction [Symbol] select {{ Primer::Alpha::Stack::DirectionArg::OPTIONS }}
      # @param direction_narrow [Symbol] select {{ Primer::Alpha::Stack::DirectionArg::OPTIONS }}
      # @param direction_regular [Symbol] select {{ Primer::Alpha::Stack::DirectionArg::OPTIONS }}
      # @param direction_wide [Symbol] select {{ Primer::Alpha::Stack::DirectionArg::OPTIONS }}
      # @param align [Symbol] select {{ Primer::Alpha::Stack::AlignArg::OPTIONS }}
      # @param align_narrow [Symbol] select {{ Primer::Alpha::Stack::AlignArg::OPTIONS }}
      # @param align_regular [Symbol] select {{ Primer::Alpha::Stack::AlignArg::OPTIONS }}
      # @param align_wide [Symbol] select {{ Primer::Alpha::Stack::AlignArg::OPTIONS }}
      # @param wrap [Symbol] select {{ Primer::Alpha::Stack::WrapArg::OPTIONS }}
      # @param wrap_narrow [Symbol] select {{ Primer::Alpha::Stack::WrapArg::OPTIONS }}
      # @param wrap_regular [Symbol] select {{ Primer::Alpha::Stack::WrapArg::OPTIONS }}
      # @param wrap_wide [Symbol] select {{ Primer::Alpha::Stack::WrapArg::OPTIONS }}
      # @param padding [Symbol] select {{ Primer::Alpha::Stack::PaddingArg::OPTIONS }}
      # @param padding_narrow [Symbol] select {{ Primer::Alpha::Stack::PaddingArg::OPTIONS }}
      # @param padding_regular [Symbol] select {{ Primer::Alpha::Stack::PaddingArg::OPTIONS }}
      # @param padding_wide [Symbol] select {{ Primer::Alpha::Stack::PaddingArg::OPTIONS }}
      def playground(
        tag: Primer::Alpha::StackItem::DEFAULT_TAG,
        justify: Primer::Alpha::Stack::JustifyArg::DEFAULT,
        justify_narrow: nil,
        justify_regular: nil,
        justify_wide: nil,
        gap: Primer::Alpha::Stack::GapArg::DEFAULT,
        gap_narrow: nil,
        gap_regular: nil,
        gap_wide: nil,
        direction: Primer::Alpha::Stack::DirectionArg::DEFAULT,
        direction_narrow: nil,
        direction_regular: nil,
        direction_wide: nil,
        align: Primer::Alpha::Stack::AlignArg::DEFAULT,
        align_narrow: nil,
        align_regular: nil,
        align_wide: nil,
        wrap: Primer::Alpha::Stack::WrapArg::DEFAULT,
        wrap_narrow: nil,
        wrap_regular: nil,
        wrap_wide: nil,
        padding: Primer::Alpha::Stack::PaddingArg::DEFAULT,
        padding_narrow: nil,
        padding_regular: nil,
        padding_wide: nil
      )
        render_with_template(locals: {
          system_arguments: {
            tag: tag,
            justify: control_values_for(justify, justify_narrow, justify_regular, justify_wide),
            gap: control_values_for(gap, gap_narrow, gap_regular, gap_wide),
            direction: control_values_for(direction, direction_narrow, direction_regular, direction_wide),
            wrap: control_values_for(wrap, wrap_narrow, wrap_regular, wrap_wide),
            padding: control_values_for(padding, padding_narrow, padding_regular, padding_wide),
            align: control_values_for(align, align_narrow, align_regular, align_wide),
          }
        })
      end

      private

      def control_values_for(normal, narrow, regular, wide)
        [narrow, regular, wide].any? ? { narrow: narrow, regular: regular, wide: wide } : normal
      end
    end
  end
end
