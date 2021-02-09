module YARD
  class RendersOneHandler < YARD::Handlers::Ruby::Base
    handles method_call(:renders_many)
    namespace_only

    process do
      name = statement.parameters.first.jump(:tstring_content, :ident).source
      object = YARD::CodeObjects::MethodObject.new(namespace, name)
      register(object)
      parse_block(statement.last, :owner => object)

      object.dynamic = true
      object[:renders_many] = true
    end
  end
end
