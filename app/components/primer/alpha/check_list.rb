# frozen_string_literal: true

module Primer
  module Alpha
    # :nodoc:
    class CheckList < ActionList
      def build_item(**system_arguments)
        # overrides = { select_mode: :multiple }

        # super(list: self, **system_arguments, **overrides)
      end
    end
  end
end
