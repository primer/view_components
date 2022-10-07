# frozen_string_literal: true

namespace :utilities do
  task :build do
    Primer::Classify::UtilityBuilder.build
  end
end
