# frozen_string_literal: true

$stdout.sync = true

require "bundler/gem_tasks"
require "rake/testtask"
require "yard"
require "primer/yard/renders_one_handler"
require "primer/yard/renders_many_handler"
require "yaml"
require "pathname"

Rake.add_rakelib "lib/tasks"

task default: :test
