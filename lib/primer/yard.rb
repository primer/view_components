# frozen_string_literal: true

module Primer
  module Yard
    autoload :Backend,              "primer/yard/backend"
    autoload :ComponentManifest,    "primer/yard/component_manifest"
    autoload :ComponentRef,         "primer/yard/component_ref"
    autoload :DocsHelper,           "primer/yard/docs_helper"
    autoload :LegacyGatsbyBackend,  "primer/yard/legacy_gatsby_backend"
    autoload :Registry,             "primer/yard/registry"
    autoload :RendersManyHandler,   "primer/yard/renders_many_handler"
    autoload :RendersOneHandler,    "primer/yard/renders_one_handler"
  end
end
