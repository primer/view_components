# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "primer/view_components/version"

Gem::Specification.new do |spec|
  spec.name          = "openproject-primer_view_components"
  spec.version       = Primer::ViewComponents::VERSION::STRING
  spec.authors       = ["GitHub Open Source", "OpenProject GmbH"]

  spec.summary       = "ViewComponents of the Primer Design System for OpenProject"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.2.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.files         = Dir["CHANGELOG.md", "LICENSE.txt", "README.md", "lib/**/*", "app/**/*", "static/**/*", "previews/**/*", "config/**/*"] - Dir["lib/**/*.rake"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "actionview", ">= 7.2.0"
  spec.add_runtime_dependency     "activesupport", ">= 7.2.0"
  spec.add_runtime_dependency     "openproject-octicons", ">= 19.25.0"
  spec.add_runtime_dependency     "view_component", [">= 3.1", "< 5.0"]
end
