# frozen_string_literal: true

namespace :coverage do
  task :report do
    require "simplecov"
    require "simplecov-console"

    SimpleCov.refuse_coverage_drop

    SimpleCov.collate Dir["simplecov-resultset-*/.resultset.json"], "rails" do
      formatter SimpleCov::Formatter::Console
    end
  end
end
