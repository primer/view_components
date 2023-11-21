# frozen_string_literal: true

begin
  require "lookbook"

  Lookbook.define_param_input(:octicon, "lookbook/previews/inputs/octicon")
  Lookbook.define_param_input(:medium_octicon, "lookbook/previews/inputs/medium_octicon")
rescue LoadError
  # Happens during docs:build, which runs in the context of the
  # PVC gem's bundle (i.e. not the demo app's bundle). Lookbook
  # may not be available in this bundle because it targets Rails
  # version >= 7.0.
end
