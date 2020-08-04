require "primer/view_components/version"

Gem::Specification.new do |spec|
  spec.name          = "primer_view_components"
  spec.version       = Primer::ViewComponents::VERSION::STRING
  spec.authors       = ["GitHub Open Source"]
  spec.email         = ["opensource+primer_view_components@github.com"]

  spec.summary       = "ViewComponents for the Primer Design System"
  spec.homepage      = "https://github.com/primer/view_components"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir["CHANGELOG.md", "LICENSE.txt", "README.md", "lib/**/*"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "rails", [">= 5.0.0", "< 7.0"]
  spec.add_runtime_dependency     "view_component", [">= 2.0.0", "< 3.0"]
  spec.add_development_dependency "minitest", "= 5.6.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rubocop", "= 0.88"
  spec.add_development_dependency "rubocop-github", "~> 0.13.0"
end
