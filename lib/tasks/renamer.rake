# frozen_string_literal: true

# bundle exec rake renamer:add_status[AvatarStack,beta]
namespace :renamer do
  task :add_status, [:target_component_name, :target_status] do |_task, args|
    require File.expand_path("./../../demo/config/environment.rb", __dir__)
    require "primer/view_components"
    # Loads all components for `.descendants` to work properly
    Dir["./app/components/primer/**/*.rb"].sort.each { |file| require file }

    target_component_name = args[:target_component_name]
    target_status = args[:target_status]

    # find the file
    filepath = File.join("app/components/primer/#{target_component_name.underscore}.rb")
    test_filepath = File.join("test/components/#{target_component_name.underscore}_test.rb")

    exists = File.file?(filepath)

    raise "can't find component file" unless exists

    # add module <status>
    component_file = File.open(filepath, "r")
    lines = component_file.readlines

    module_primer_line_index = 0
    lines.each_with_index do |line, i|
      module_primer_line_index = i if line.include?("module Primer")
    end
    raise "can't find 'module Primer' line" if module_primer_line_index.zero?

    puts "adding module <status> line"
    lines.insert(module_primer_line_index + 1, "module #{target_status.capitalize}")
    lines.push("end")

    File.open(filepath, mode: "w") do |f|
      lines.each { |line| f.puts(line) }
    end

    filepath_with_status = filepath.gsub("/primer/", "/primer/#{target_status}/")

    # drop component suffix in filepath if presen't
    filepath_with_status.gsub!("_component.rb", ".rb") if filepath_with_status.end_with?("component.rb")

    puts "moving from #{filepath} to #{filepath_with_status}"
    mv_result = %x(`git mv #{filepath} #{filepath_with_status}`)
    puts mv_result

    # rename test filename too
    test_filepath_with_status = test_filepath.gsub("/components/", "/components/#{target_status}/")

    # drop component suffix in filepath if presen't
    test_filepath_with_status.gsub!("_component_test.rb", "_test.rb") if test_filepath_with_status.end_with?("component_test.rb")

    puts "moving from #{test_filepath} to #{test_filepath_with_status}"
    mv_result = %x(`git mv #{test_filepath} #{test_filepath_with_status}`)
    puts mv_result

    # TODO: rename template filename too

    # rename in codebase for status and suffix
    if target_component_name.end_with?("Component")
      updated_component_name = target_component_name.gsub("Component", "")

      # TODO: don't add Beta:: in class definition
      puts "greping to drop Component suffix"
      rename_result = %x(`grep -rl #{target_component_name} . --exclude=CHANGELOG.md | xargs sed -i 's/#{target_component_name}/#{target_status.capitalize}::#{updated_component_name}/g'`)
      puts rename_result
    end

    puts "updates done"

    puts "running rubocop to fix formatting"
    %x(`bundle exec rubocop -a`)

    puts "done!"
  end
end
