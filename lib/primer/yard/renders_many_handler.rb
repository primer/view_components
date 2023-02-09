# frozen_string_literal: true

# :nocov:
module Primer
  module Yard
    # YARD Handler to parse `renders_many` calls.
    class RendersManyHandler < ::YARD::Handlers::Ruby::Base
      handles method_call(:renders_many)
      namespace_only

      process do
        name = statement.parameters.first.jump(:tstring_content, :ident).source
        object = ::YARD::CodeObjects::MethodObject.new(namespace, name)
        register(object)
        parse_block(statement.last, owner: object)

        object.dynamic = true
        object[:renders_many] = true
      end
    end
  end
end
# :nocov:
