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
  
  # Filter demo app files that appear without the demo/ prefix due to Rails.root context
  add_filter do |src_file|
    # Check if this is a demo app file by looking at the full path
    full_path = File.expand_path(src_file.filename)
    full_path.include?("/demo/app/")
  end
  command_name "rails#{ENV['RAILS_VERSION']}-ruby#{ENV['RUBY_VERSION']}" if ENV["RUBY_VERSION"]

  formatter SimpleCov::Formatter::Console
  SimpleCov::Formatter::Console.max_rows = 50
  SimpleCov::Formatter::Console.output_style = "block"

  add_group "Ignored Code" do |src_file|
    File.readlines(src_file.filename).grep(/:nocov:/).any?
  end
end
