# frozen_string_literal: true

# :nocov:
module Primer
  module Yard
    # YARD Handler to parse `renders_one` calls.
    class RendersOneHandler < ::YARD::Handlers::Ruby::Base
      handles method_call(:renders_one)
      namespace_only

      process do
        name = statement.parameters.first.jump(:tstring_content, :ident).source
        object = ::YARD::CodeObjects::MethodObject.new(namespace, name)
        register(object)
        parse_block(statement.last, owner: object)

        object.dynamic = true
        object[:renders_one] = true
      end
    end
  end
end
# :nocov:
