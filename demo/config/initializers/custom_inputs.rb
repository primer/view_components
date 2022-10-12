# frozen_string_literal: true

begin
  require "lookbook"

  Lookbook.define_param_input(:octicon, "lookbook/previews/inputs/octicon")
rescue NameError
end
