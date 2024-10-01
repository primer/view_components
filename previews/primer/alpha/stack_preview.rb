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
        justify_narrow: Primer::Alpha::Stack::JustifyArg::DEFAULT,
        justify_regular: Primer::Alpha::Stack::JustifyArg::DEFAULT,
        justify_wide: Primer::Alpha::Stack::JustifyArg::DEFAULT,
        gap: Primer::Alpha::Stack::GapArg::DEFAULT,
        gap_narrow: Primer::Alpha::Stack::GapArg::DEFAULT,
        gap_regular: Primer::Alpha::Stack::GapArg::DEFAULT,
        gap_wide: Primer::Alpha::Stack::GapArg::DEFAULT,
        direction: Primer::Alpha::Stack::DirectionArg::DEFAULT,
        direction_narrow: Primer::Alpha::Stack::DirectionArg::DEFAULT,
        direction_regular: Primer::Alpha::Stack::DirectionArg::DEFAULT,
        direction_wide: Primer::Alpha::Stack::DirectionArg::DEFAULT,
        align: Primer::Alpha::Stack::AlignArg::DEFAULT,
        align_narrow: Primer::Alpha::Stack::AlignArg::DEFAULT,
        align_regular: Primer::Alpha::Stack::AlignArg::DEFAULT,
        align_wide: Primer::Alpha::Stack::AlignArg::DEFAULT,
        wrap: Primer::Alpha::Stack::WrapArg::DEFAULT,
        wrap_narrow: Primer::Alpha::Stack::WrapArg::DEFAULT,
        wrap_regular: Primer::Alpha::Stack::WrapArg::DEFAULT,
        wrap_wide: Primer::Alpha::Stack::WrapArg::DEFAULT,
        padding: Primer::Alpha::Stack::PaddingArg::DEFAULT,
        padding_narrow: Primer::Alpha::Stack::PaddingArg::DEFAULT,
        padding_regular: Primer::Alpha::Stack::PaddingArg::DEFAULT,
        padding_wide: Primer::Alpha::Stack::PaddingArg::DEFAULT
      )
        render_with_template(locals: {
          system_arguments: {
            tag: tag,

            justify: [
              justify,
              justify_narrow,
              justify_regular,
              justify_wide,
              justify_wide
            ],

            gap: [
              gap,
              gap_narrow,
              gap_regular,
              gap_wide,
              gap_wide
            ],

            direction: [
              direction,
              direction_narrow,
              direction_regular,
              direction_wide,
              direction_wide
            ],

            wrap: [
              wrap,
              wrap_narrow,
              wrap_regular,
              wrap_wide,
              wrap_wide
            ],

            padding: [
              padding,
              padding_narrow,
              padding_regular,
              padding_wide,
              padding_wide
            ],

            align: [
              align,
              align_narrow,
              align_regular,
              align_wide,
              align_wide
            ],
          }
        })
      end
    end
  end
end
