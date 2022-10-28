# frozen_string_literal: true

require "primer/classify/utility_builder"

namespace :utilities do

  desc "Build PVC Classify data for CSS"
  task :build do

    Primer::Classify::UtilityBuilder.build
  end
end
