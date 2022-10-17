# frozen_string_literal: true

require "rake/testtask"

namespace :test do
  desc "Run all tests"
  task all: [:fast, :system, :accessibility, :performance]

  Rake::TestTask.new(:single) do |t|
    ENV["TZ"] = "Asia/Taipei"

    t.warning = false
    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList[ENV["TEST"]]
  end

  Rake::TestTask.new(:fast) do |t|
    ENV["TZ"] = "Asia/Taipei"
    ENV["COVERAGE"] = "1"

    t.warning = false
    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList[
      "test/components/**/*_test.rb",
      "test/lib/**/*_test.rb",
      "test/primer/**/*_test.rb",
      "test/linters/**/*_test.rb",
      "test/rubocop/**/*_test.rb"
    ]
  end

  Rake::TestTask.new(:system) do |t|
    ENV["TZ"] = "Asia/Taipei"

    t.warning = false
    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList["test/system/**/*_test.rb"]
  end

  Rake::TestTask.new(:performance) do |t|
    ENV["TZ"] = "Asia/Taipei"

    t.libs << "test"
    t.test_files = FileList["test/performance/**/*_test.rb", "test/performance/**/bench_*.rb"]
    t.verbose = true
  end

  Rake::TestTask.new(:accessibility) do |t|
    ENV["TZ"] = "Asia/Taipei"

    t.warning = false
    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList["test/accessibility_test.rb"]
  end

  Rake::TestTask.new(:snapshots) do |t|
    ENV["TZ"] = "Asia/Taipei"

    t.warning = false
    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList["test/snapshots_test.rb"]
  end

  task :coverage do
    require "simplecov"

    # Goal is 100% coverage
    SimpleCov.minimum_coverage 99
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
