# frozen_string_literal: true

module Primer
  module Alpha
    # @label SelectList
    class SelectListPreview < ViewComponent::Preview
      # @label Playground
      def playground
        render(Primer::Alpha::SelectList.new(name: :places, label: "Places")) do |c|
          c.option(label: "Lopez Island", value: "lopez")
          c.option(label: "Shaw Island", value: "shaw")
          c.option(label: "Orcas Island", value: "orcas")
          c.option(label: "San Juan Island", value: "san_juan")
        end
      end
    end
  end
end
