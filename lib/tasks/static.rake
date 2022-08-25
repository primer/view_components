# frozen_string_literal: true

namespace :static do
  task :dump do
    require File.expand_path("./../../demo/config/environment.rb", __dir__)
    require "primer/view_components"
    # Loads all components for `.descendants` to work properly
    Dir["./app/components/primer/**/*.rb"].sort.each { |file| require file }

    Primer::ViewComponents.dump(:statuses)
    Primer::ViewComponents.dump(:constants)
    Primer::ViewComponents.dump(:audited_at)
  end
end
