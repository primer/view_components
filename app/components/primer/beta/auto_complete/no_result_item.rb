require_relative "item"

module Primer 
  module Beta
    class AutoComplete
      class NoResultItem < Item
        def initialize(**system_arguments)
          super(
            role: :presentation,
            aria: merge_aria(
              { aria: { hidden: true } },
              system_arguments
            ),
            value: "",
            disabled: true,
            'data-no-result-found': true,
            **system_arguments
          )
        end
      end
    end
  end
end