# frozen_string_literal: true

namespace :coverage do
  task :report do
    require "simplecov"
    require "simplecov-console"

    SimpleCov.minimum_coverage 99

    SimpleCov.collate Dir["simplecov-resultset-*/.resultset.json"], "rails" do
      formatter SimpleCov::Formatter::Console

      add_group "Ignored Code" do |src_file|
        File.readlines(src_file.filename).grep(/:nocov:/).any?
      end
    end
  end
end
