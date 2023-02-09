# :nocov:

begin
  require 'kuby'
  Kuby.load!
rescue LoadError, Kuby::MissingConfigError
  # Happens during docs:build, which runs in the context of the
  # view_component gem's bundle (i.e. not the demo app's bundle)
  # and therefore doesn't have any of the kuby-* gems loaded. It
  # should be no problem to skip loading Kuby in this case.
end
