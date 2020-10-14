# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "yard"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

YARD::Rake::YardocTask.new

namespace :coverage do
  task :report do
    require "simplecov"
    require "simplecov-console"

    SimpleCov.minimum_coverage 100

    SimpleCov.collate Dir["simplecov-resultset-*/.resultset.json"], "rails" do
      formatter SimpleCov::Formatter::Console
    end
  end
end

namespace :docs do
  task :livereload do
    require "listen"

    Rake::Task["docs:build"].execute

    puts "Listening for changes to documentation..."

    listener = Listen.to("app") do |modified, added, removed|
      puts "modified absolute path: #{modified}"
      puts "added absolute path: #{added}"
      puts "removed absolute path: #{removed}"

      Rake::Task["docs:build"].execute
    end
    listener.start # not blocking
    sleep
  end

  task :build do
    require File.expand_path("../demo/config/environment.rb", __FILE__)
    require "primer/view_components"
    require "view_component/test_helpers"
    include ViewComponent::TestHelpers

    puts "Building YARD documentation."
    Rake::Task["yard"].execute

    puts "Converting YARD documentation to Markdown files."

    registry = YARD::RegistryStore.new
    registry.load!(".yardoc")
    components = [
      Primer::AvatarComponent,
      Primer::BaseComponent,
      Primer::BlankslateComponent,
      Primer::CounterComponent
    ]
    components.each do |component|
      documentation = registry.get(component.name)

      File.open("docs/content/components/#{component.name.demodulize.gsub("Component", "").downcase}.md", "w") do |f|
        f.puts("---")
        f.puts("title: #{component.name}")
        f.puts("---")
        f.puts
        f.puts(documentation.base_docstring)
        f.puts
        f.puts("## Examples")
        f.puts

        initialize_method = documentation.meths.find(&:constructor?)

        request = ActionDispatch::TestRequest.create
        controller = ApplicationController.new.tap { |c| c.request = request }

        initialize_method.tags(:example).each do |tag|
          iframe_height = tag.name.split("|").first
          name = tag.name.split("|")[1]
          description = tag.name.split("|")[2]

          f.puts("### #{name}")
          f.puts(description) if description
          f.puts
          html = controller.view_context.render(inline: tag.text)

          f.puts("<iframe style=\"width: 100%; border: 0px; height: #{iframe_height}px;\" srcdoc=\"<html><head><link href=\'https://unpkg.com/@primer/css/dist/primer.css\' rel=\'stylesheet\'></head><body>#{html.gsub("\"", "\'").gsub("\n", "")}</body></html>\"></iframe>")
          f.puts
          f.puts("```ruby")
          f.puts("#{tag.text}")
          f.puts("```")
        end

        f.puts
        f.puts("## Arguments")
        f.puts
        f.puts("| Name | Type | Default | Description |")
        f.puts("| :- | :- | :-: | :- |")

        initialize_method.tags(:param).each do |tag|
          params = tag.object.parameters.find { |param| [tag.name.to_s, tag.name.to_s + ":"].include?(param[0]) }

          default =
            if params && params[1]
              params[1]
            else
              ""
            end


          f.puts("| #{tag.name} | #{tag.types.join(", ")} | #{default} | #{controller.view_context.render(inline: tag.text)} |")
        end
      end
    end

    puts "Markdown compiled."
  end
end

task default: :test
