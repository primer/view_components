# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "yard"
require "yard/renders_one_handler"
require "yard/renders_many_handler"
require "yaml"
require "pathname"

Rake::TestTask.new(:test) do |t|
  ENV["TZ"] = "Asia/Taipei"

  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList[ENV["TESTS"] || "test/**/*_test.rb"]
end

Rake::TestTask.new(:bench) do |t|
  # Disable parallel tests since it can interfere with benchmark results and allocation counts
  ENV["MT_CPU"] = "0"
  t.libs << "test"
  t.test_files = FileList["test/benchmarks/**/bench_*.rb"]
  t.verbose = true
end

Rake.add_rakelib "lib/tasks"

task default: :test
