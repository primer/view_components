# frozen_string_literal: true

module ERBLint
  module Linters
    module Helpers
      # Provides helpers related to RuboCop.
      module RubocopHelpers
        def erb_ast(code)
          RuboCop::AST::ProcessedSource.new(code, RUBY_VERSION.to_f).ast
        end
      end
    end
  end
end
