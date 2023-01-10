# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "primer/view_components/version"

Gem::Specification.new do |spec|
  spec.name          = "primer_view_components"
  spec.version       = Primer::ViewComponents::VERSION::STRING
  spec.authors       = ["GitHub Open Source"]
  spec.email         = ["opensource+primer_view_components@github.com"]

  spec.summary       = "ViewComponents for the Primer Design System"
  spec.homepage      = "https://github.com/primer/view_components"
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

  spec.files         = Dir["CHANGELOG.md", "LICENSE.txt", "README.md", "lib/**/*", "app/**/*", "static/**/*", "previews/**/*"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "actionview", ">= 5.0.0"
  spec.add_runtime_dependency     "activesupport", ">= 5.0.0"
  spec.add_runtime_dependency     "octicons", ">= 17.0.0"
  spec.add_runtime_dependency     "view_component", [">= 2.81.0", "< 3.0"]

  spec.add_development_dependency "allocation_stats", "~> 0.1"
  spec.add_development_dependency "allocation_tracer", "~> 0.6.3"
  spec.add_development_dependency "axe-core-api", "~> 4.2.0"
  spec.add_development_dependency "benchmark-ips", "~> 2.8.4"
  spec.add_development_dependency "capybara", "~> 3"
  spec.add_development_dependency "cuprite", "= 0.13"
  spec.add_development_dependency "erb_lint"
  spec.add_development_dependency "erblint-github", "0.1.0"
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
