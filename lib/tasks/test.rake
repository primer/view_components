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

  Rake::TestTask.new(:snapshots) do |t|
    t.warning = false
    t.libs << "test"
    t.test_files = FileList["test/snapshots_test.rb"]
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

task "test:snapshots" => :clean_snapshots
task :clean_snapshots do
  # Clear folder
  FileUtils.rm_rf("test/snapshots")
end
