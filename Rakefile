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

    puts "Building YARD documentation."
    Rake::Task["yard"].execute

    puts "Converting YARD documentation to Markdown files."

    registry = YARD::RegistryStore.new
    registry.load!(".yardoc")
    component = Primer::CounterComponent
    documentation = registry.get(component.name)

    File.open("docs/content/components/#{component.name.demodulize.gsub("Component", "").downcase}.md", "w") do |f|
      f.puts("---")
      f.puts("title: #{component.name}")
      f.puts("---")
      f.puts
      f.puts(documentation.base_docstring)
      f.puts
      f.puts("## Arguments")
      f.puts
      f.puts("| Name | Type | Default | Description |")
      f.puts("| :- | :- | :-: | :- |")

      initialize_method = documentation.meths.find(&:constructor?)

      initialize_method.tags.each do |tag|
        if tag.tag_name == "param"
          o = tag.object.parameters.find { |a| [tag.name.to_s, tag.name.to_s + ":"].include?(a[0]) }

          default =
            if o && o[1]
              o[1]
            else
              ""
            end


          f.puts("| #{tag.name} | #{tag.types.join(", ")} | #{default} | #{tag.text} |")
        end
      end
    end

    puts "Markdown compiled."
  end
end

task default: :test
