# frozen_string_literal: true

require "active_support/inflector"

task :init_pvc do
  require "primer/yard"

  ENV["RAILS_ENV"] = "test"
  ENV["VC_COMPAT_PATCH_ENABLED"] = "true"

  require File.expand_path("./../../demo/config/environment.rb", __dir__)
  Dir[File.expand_path("../../app/components/primer/**/*.rb", __dir__)].sort.each { |file| require file }
end

namespace :docs do
  task :livereload do
    require "listen"

    Rake::Task["docs:build"].execute

    puts "Listening for changes to documentation..."

    listener = Listen.to("app") do |modified, added, removed|
      puts "modified absolute path: #{modified}"
      puts "added absolute path: #{added}"
      puts "removed absolute path: #{removed}"

      Rake::Task["docs:build"].execute
    end
    listener.start # not blocking
    sleep
  end

  task build: [:build_lookbook_pages]

  task build_lookbook_pages: :build_yard_registry do
    require "primer/yard"

    registry = Primer::Yard::Registry.make
    manifest = Primer::Yard::ComponentManifest.where(form_component: true)
    backend = Primer::Yard::LookbookPagesBackend.new(registry, manifest)
    backend.generate
  end

  task build_yard_registry: :init_pvc do
    require "primer/yard"

    ::YARD::Rake::YardocTask.new do |task|
      task.options << "--no-output"
    end

    # Custom tags for yard
    ::YARD::Tags::Library.define_tag("Accessibility", :accessibility)
    ::YARD::Tags::Library.define_tag("Deprecation", :deprecation)
    ::YARD::Tags::Library.define_tag("Parameter", :param, :with_types_name_and_default)
    ::YARD::Tags::Library.define_tag("Form Usage", :form_usage)

    puts "Building YARD documentation."
    Rake::Task["yard"].execute
  end
end
