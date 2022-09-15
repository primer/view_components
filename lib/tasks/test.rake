# frozen_string_literal: true

require "rake/testtask"

namespace :test do
  desc "Run all tests"
  task fast: [:components, :lib, :linters]
  task all: [:fast, :system]

  Rake::TestTask.new(:single) do |t|
    ENV["TZ"] = "Asia/Taipei"

    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList[ENV["TESTS"]]
  end

  Rake::TestTask.new(:components) do |t|
    ENV["TZ"] = "Asia/Taipei"

    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList["test/components/**/*_test.rb"]
  end

  Rake::TestTask.new(:lib) do |t|
    ENV["TZ"] = "Asia/Taipei"

    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList["test/lib/**/*_test.rb", "test/primer/**/*_test.rb"]
  end

  Rake::TestTask.new(:linters) do |t|
    ENV["TZ"] = "Asia/Taipei"

    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList["test/linters/**/*_test.rb", "test/rubocop/**/*_test.rb"]
  end

  Rake::TestTask.new(:system) do |t|
    ENV["TZ"] = "Asia/Taipei"

    t.libs << "test"
    t.libs << "lib"
    t.test_files = FileList["test/system/**/*_test.rb", "test/previews/**/*_test.rb"]
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
