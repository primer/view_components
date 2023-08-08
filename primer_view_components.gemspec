# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "primer/view_components/version"

Gem::Specification.new do |spec|
  spec.name          = "primer_view_components"
  spec.version       = Primer::ViewComponents::VERSION::STRING
  spec.authors       = ["GitHub Open Source"]

  spec.summary       = "ViewComponents of the Primer Design System for OpenProject"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir["CHANGELOG.md", "LICENSE.txt", "README.md", "lib/**/*", "app/**/*", "static/**/*", "previews/**/*"] - Dir["lib/**/*.rake"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "actionview", ">= 5.0.0"
  spec.add_runtime_dependency     "activesupport", ">= 5.0.0"
  spec.add_runtime_dependency     "openproject-octicons", ">= 19.6.7"
  spec.add_runtime_dependency     "view_component", [">= 3.1", "< 4.0"]

  spec.add_development_dependency "allocation_stats", "~> 0.1"
  spec.add_development_dependency "allocation_tracer", "~> 0.6.3"
  spec.add_development_dependency "benchmark-ips", "~> 2.8.4"
  spec.add_development_dependency "capybara", "~> 3.39.2"
  spec.add_development_dependency "cuprite", "~> 0.14.3"
  spec.add_development_dependency "erb_lint", "~> 0.4.0"
  spec.add_development_dependency "erblint-github", "0.4.0"
  spec.add_development_dependency "listen", "~> 3.0"
  spec.add_development_dependency "matrix", "~> 0.4.2"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rubocop", "= 1.13.0"
  spec.add_development_dependency "rubocop-github", "~> 0.16.0"
  spec.add_development_dependency "rubocop-performance", "~> 1.7"
  spec.add_development_dependency "simplecov", "~> 0.21.2"
  spec.add_development_dependency "simplecov-console", "~> 0.9.1"
  spec.add_development_dependency "sprockets"
  spec.add_development_dependency "sprockets-rails"
  spec.add_development_dependency "thor"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "yard", "~> 0.9.25"
end
