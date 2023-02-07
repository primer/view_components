# frozen_string_literal: true

require "active_support/inflector"

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

  task build: [:build_gatsby, :build_gatsby_adrs]

  task build_gatsby: :build_yard_registry do
    registry = Primer::YARD::Registry.make

    require "primer/yard/legacy_gatsby_backend"

    puts "Converting YARD documentation to Markdown files."

    # Deletes docs before regenerating them, guaranteeing that we don't keep stale docs.
    components_content_glob = File.join(*%w[docs content components ** *.md])
    FileUtils.rm_rf(components_content_glob)

    backend = Primer::YARD::LegacyGatsbyBackend.new(registry)
    args_for_components, errors = backend.generate

    unless errors.empty?
      puts "==============================================="
      puts "===================== ERRORS =================="
      puts "===============================================\n\n"
      puts JSON.pretty_generate(errors)
      puts "\n\n==============================================="
      puts "==============================================="
      puts "==============================================="

    raise
    end

    File.open("static/arguments.json", "w") do |f|
      f.puts JSON.pretty_generate(args_for_components)
    end

    puts "Markdown compiled."

    components_needing_docs = Primer::YARD::ComponentManifest.components_without_docs

    if components_needing_docs.any?
      puts
      puts "The following components needs docs. Care to contribute them? #{components_needing_docs.map(&:name).join(', ')}"
    end
  end

  task build_lookbook_pages: :build_yard_registry do
    require "primer/yard"

    registry = Primer::Yard::Registry.make
    manifest = Primer::Yard::ComponentManifest.where(form_component: true)
    backend = Primer::Yard::LookbookPagesBackend.new(registry, manifest)
    backend.generate
  end

  task :build_gatsby_adrs do
    adr_content_dir = File.join(*%w[docs content adr])

    FileUtils.rm_rf(File.join(adr_content_dir))
    FileUtils.mkdir(adr_content_dir)

    nav_entries = Dir[File.join(*%w[docs adr *.md])].sort.map do |orig_path|
      orig_file_name = File.basename(orig_path)
      url_name = orig_file_name.chomp(".md")

      file_contents = File.read(orig_path)
      file_contents = <<~CONTENTS.sub(/\n+\z/, "\n")
        <!-- Warning: AUTO-GENERATED file, do not edit. Make changes to the files in the adr/ directory instead. -->
        #{file_contents}
      CONTENTS

      title_match = /^# (.+)/.match(file_contents)
      title = title_match[1]

      # Don't include initial ADR for recording ADRs
      next nil if title == "Record architecture decisions"

      File.write(File.join(adr_content_dir, orig_file_name), file_contents)
      puts "Copied #{orig_path}"

      { "title" => title, "url" => "/adr/#{url_name}" }
    end

    nav_yaml_file = File.join(*%w[docs src @primer gatsby-theme-doctocat nav.yml])
    nav_yaml = YAML.load_file(nav_yaml_file)
    adr_entry = {
      "title" => "Architecture decisions",
      "children" => nav_entries.compact
    }

    existing_index = nav_yaml.index { |entry| entry["title"] == "Architecture decisions" }
    if existing_index
      nav_yaml[existing_index] = adr_entry
    else
      nav_yaml << adr_entry
    end

    File.write(nav_yaml_file, YAML.dump(nav_yaml))
  end

  task preview: :build_yard_registry do
    registry = Primer::YARD::Registry.make

    require "primer/yard/legacy_gatsby_backend"

    FileUtils.rm_rf("previews/primer/docs/")

    manifest = Primer::YARD::ComponentManifest

    # Generate previews from documentation examples
    manifest.all_components.each do |component|
      docs = registry.find(component)
      next unless docs.constructor&.tags(:example)&.any?

      yard_example_tags = docs.constructor.tags(:example)

      path = Pathname.new("previews/docs/#{docs.short_name.underscore}_preview.rb")
      path.dirname.mkdir unless path.dirname.exist?

      File.open(path, "w") do |f|
        f.puts("module Docs")
        f.puts("  class #{docs.short_name}Preview < ViewComponent::Preview")

        yard_example_tags.each_with_index do |tag, index|
          name, _, code = Primer::YARD::LegacyGatsbyBackend.parse_example_tag(tag)
          method_name = name.split("|").first.downcase.parameterize.underscore
          f.puts("    def #{method_name}; end")
          f.puts unless index == yard_example_tags.size - 1
          path = Pathname.new("previews/docs/#{docs.short_name.underscore}_preview/#{method_name}.html.erb")
          path.dirname.mkdir unless path.dirname.exist?
          File.open(path, "w") do |view_file|
            view_file.puts(code.to_s)
          end
        end

        f.puts("  end")
        f.puts("end")
      end
    end
  end

  task :init_pvc do
    ENV["RAILS_ENV"] = "test"
    require File.expand_path("./../../demo/config/environment.rb", __dir__)
    Dir["./app/components/primer/**/*.rb"].sort.each { |file| require file }
  end

  task build_yard_registry: :init_pvc do
    require "primer/yard/registry"

    ::YARD::Rake::YardocTask.new do |task|
      task.options << "--no-output"
    end

    # Custom tags for yard
    ::YARD::Tags::Library.define_tag("Accessibility", :accessibility)
    ::YARD::Tags::Library.define_tag("Deprecation", :deprecation)
    ::YARD::Tags::Library.define_tag("Parameter", :param, :with_types_name_and_default)
    ::YARD::Tags::Library.define_tag("Form Usage", :form_usage)

    puts "Building YARD documentation."
    Rake::Task["yard"].execute
  end
end
