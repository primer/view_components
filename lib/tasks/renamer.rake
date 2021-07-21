# frozen_string_literal: true

# bundle exec rake renamer:add_status[AvatarStack,beta]
namespace :renamer do
  task :add_status, [:target_component_name, :target_status] do |task, args|
    require File.expand_path("./../../demo/config/environment.rb", __dir__)
    require "primer/view_components"
    # Loads all components for `.descendants` to work properly
    Dir["./app/components/primer/**/*.rb"].sort.each { |file| require file }
    
    target_component_name = args[:target_component_name]
    target_status = args[:target_status]

    # find the file
    filepath = File.join("app/components/primer/#{target_component_name.underscore}.rb")

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
    lines.insert(module_primer_line_index+1, "module #{target_status.capitalize}")

    File.open(filepath, mode: "w") do |f|
      lines.each { |line| f.puts(line) }
    end

    filepath_with_status = filepath.gsub("/primer/", "/primer/#{target_status}/")

    puts "moving from #{filepath} to #{filepath_with_status}"
    mv_result = %x(`git mv #{filepath} #{filepath_with_status}`)
    puts mv_result

    # drop component suffix in filepath if presen't
    if filepath_with_status.end_with?("component.rb")
        filepath_with_status.gsub!("component.rb", ".rb")
    end

    # rename in codebase for status and suffix
    if target_component_name.end_with?("Component")
      updated_component_name = target_component_name.gsub("Component", "")
      
      puts "greping to drop Component suffix"
      rename_result = %x(`grep -rl #{target_component_name} | xargs sed -i 's/#{target_component_name}/#{updated_component_name}/g'`)
      puts rename_result
    end

    puts "tada"
  end
end