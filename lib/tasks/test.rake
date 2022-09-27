# frozen_string_literal: true

require "rake/testtask"

namespace :test do
  desc "Run all tests"
  task all: [:fast, :system]

  Rake::TestTask.new(:single) do |t|
    ENV["TZ"] = "Asia/Taipei"

    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList[ENV["TESTS"]]
  end

  Rake::TestTask.new(:fast) do |t|
    ENV["TZ"] = "Asia/Taipei"

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

    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList["test/system/**/*_test.rb"]
  end

  Rake::TestTask.new(:bench) do |t|
    t.libs << "test"
    t.test_files = FileList["test/benchmarks/**/bench_*.rb"]
    t.verbose = true
  end
end

task :test do
  if ENV["TESTS"]
    Rake::Task["test:single"].invoke
  else
    Rake::Task["test:all"].invoke
  end
end

task bench: "test:bench"
