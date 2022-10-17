# frozen_string_literal: true

require "rake/testtask"

namespace :test do
  desc "Run all tests"
  task all: [:fast, :lib, :system, :accessibility, :performance]

  Rake::TestTask.new(:single) do |t|
    ENV["TZ"] = "Asia/Taipei"

    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList[ENV["TEST"]]
  end

  Rake::TestTask.new(:fast) do |t|
    ENV["TZ"] = "Asia/Taipei"

    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList[
      "test/components/**/*_test.rb",
      "test/primer/**/*_test.rb",
    ]
  end

  task :lib do
    ENV["COVERAGE"] = "1"

    ENV["TEST"] = "test/lib/**/*_test.rb"
    Rake::Task["test:single"].invoke
  end

  task :coverage do
    require "simplecov"
    require "simplecov-console"

    SimpleCov.minimum_coverage 100

    SimpleCov.collate Dir["coverage/.resultset.json"], "rails" do
      formatter SimpleCov::Formatter::Console
      SimpleCov::Formatter::Console.max_rows = 50
      SimpleCov::Formatter::Console.output_style = "block"

      add_group "Ignored Code" do |src_file|
        File.readlines(src_file.filename).grep(/:nocov:/).any?
      end
    end
  end

  Rake::TestTask.new(:system) do |t|
    ENV["TZ"] = "Asia/Taipei"

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

    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList["test/accessibility_test.rb"]
  end

  Rake::TestTask.new(:snapshots) do |t|
    ENV["TZ"] = "Asia/Taipei"

    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList["test/snapshots_test.rb"]
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
