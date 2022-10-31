# frozen_string_literal: true

require "rake/testtask"

namespace :test do
  desc "Run all tests"
  task all: [
    :components,
    :lib,
    :system,
    :accessibility,
    :performance
  ]

  Rake::TestTask.new(:single) do |t|
    t.warning = false
    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList[ENV["TEST"]]
  end

  Rake::TestTask.new(:components) do |t|
    t.warning = false
    t.libs << "test"
    t.test_files = FileList[
      "test/components/**/*_test.rb"
    ]
  end

  Rake::TestTask.new(:lib) do |t|
    t.warning = false
    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList[
      "test/lib/**/*_test.rb"
    ]
  end

  Rake::TestTask.new(:system) do |t|
    t.warning = false
    t.libs << "test"
    t.test_files = FileList["test/system/**/*_test.rb"]
  end

  Rake::TestTask.new(:performance) do |t|
    t.warning = false
    t.verbose = true
    t.libs << "test"
    t.test_files = FileList[
      "test/performance/**/*_test.rb",
      "test/performance/**/bench_*.rb"
    ]
  end

  Rake::TestTask.new(:accessibility) do |t|
    t.warning = false
    t.libs << "test"
    t.test_files = FileList["test/accessibility_test.rb"]
  end

  task :snapshots do
    ENV["TEST"] = "test/snapshots_test.rb"
    Rake::Task["test:single"].invoke
  end

  task "snapshots:clean" do
    puts "Cleaning snapshots"

    # Load the previews
    require "view_component"
    Dir["./previews/**/*.rb"].sort.each { |file| require file }

    previews_with_method = []

    ViewComponent::Preview.descendants.each do |klass|
      preview = klass.to_s.underscore.gsub("_preview", "")
      methods = klass.instance_methods(false)
      methods.each do |method|
        previews_with_method << "#{preview}/#{method}"
      end
    end

    Dir["test/snapshots/**/*.png"].each do |file|
      component_uri = file.sub("test/snapshots/", "").sub(%r{/[^/]+$}, "")
      FileUtils.rm(file) unless previews_with_method.include?(component_uri)
    end
  end

  task :coverage do
    require "simplecov"

    SimpleCov.minimum_coverage 100
    SimpleCov.collate Dir["coverage/.resultset.json"], "rails"
  end
end

task :test do
  if ENV["TEST"]
    Rake::Task["test:single"].invoke
  else
    Rake::Task["test:all"].invoke
  end
end

task "test:snapshots" => "test:snapshots:clean"
