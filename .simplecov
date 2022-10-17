# frozen_string_literal: true

require "simplecov-console"

SimpleCov.start "rails" do
  add_filter [
    "demo/",
    "previews/",
    "test/test_helpers/",
    "lib/tasks",
    "lib/yard"
  ]
  command_name "rails#{ENV['RAILS_VERSION']}-ruby#{ENV['RUBY_VERSION']}" if ENV["RUBY_VERSION"]

  formatter SimpleCov::Formatter::Console
  SimpleCov::Formatter::Console.max_rows = 50
  SimpleCov::Formatter::Console.output_style = "block"

  add_group "Ignored Code" do |src_file|
    File.readlines(src_file.filename).grep(/:nocov:/).any?
  end
end
