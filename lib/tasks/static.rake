# frozen_string_literal: true

namespace :static do
  task :dump do
    ENV["RAILS_ENV"] = "test"
    require File.expand_path("./../../demo/config/environment.rb", __dir__)
    require "primer/view_components"
    require "lookbook"
    # Loads all components for `.descendants` to work properly
    Dir["./app/components/primer/**/*.rb"].sort.each { |file| require file }

    Primer::ViewComponents.dump(:statuses)
    Primer::ViewComponents.dump(:constants)
    Primer::ViewComponents.dump(:audited_at)

    previews = Lookbook.previews.map do |preview|
      {
        name: preview.name,
        lookup_path: preview.lookup_path,
        examples: preview.examples.map { |example|
          {
            inspect_path: example.url_path,
            preview_path: example.url_path.sub("/inspect/", "/preview/"),
            name: example.name
          }
        }
      }
    end

    require "json"

    File.open(File.join(Primer::ViewComponents::DEFAULT_STATIC_PATH, "previews.json"), "w") do |f|
      f.write(JSON.pretty_generate(previews))
      f.write($INPUT_RECORD_SEPARATOR)
    end
  end
end
