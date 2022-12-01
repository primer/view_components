# frozen_string_literal: true

module Primer
  module Forms
    module TestComponents
      class Foo < Primer::Forms::BaseComponent
        def initialize(render: true)
          @render = render
        end

        def render?
          @render
        end
      end
    end
  end
end
