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

  namespace :build do
    task :css do
      Dir.chdir("demo/") do
        # if vite is running in prod mode, we're probably running tests, see script/test-setup
        if ENV["VITE_RUBY_MODE"] != "production"
          system "npm run build:css"
          system "bin/vite build"
        end
      end
    end
  end

  Rake::TestTask.new(:single) do |t|
    t.deps = "test:build:css"
    t.warning = false
    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList[ENV["TEST"]]
  end

  Rake::TestTask.new(:components) do |t|
    t.deps = "test:build:css"
    t.warning = false
    t.libs << "test"
    t.test_files = FileList[
      "test/components/**/*_test.rb"
    ]
  end

  Rake::TestTask.new(:component_css) do |t|
    t.deps = "test:build:css"
    t.warning = false
    t.libs << "test"
    t.test_files = FileList[
      "test/css/**/*_test.rb"
    ]
  end

  Rake::TestTask.new(:lib) do |t|
    t.deps = "test:build:css"
    t.warning = false
    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList[
      "test/lib/**/*_test.rb"
    ]
  end

  Rake::TestTask.new(:system) do |t|
    t.deps = "test:build:css"
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
    t.deps = "test:build:css"
    t.warning = false
    t.libs << "test"
    t.test_files = FileList["test/accessibility_test.rb"]
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
