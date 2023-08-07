# frozen_string_literal: true

require "active_support/inflector"

task :init_pvc do
  require "primer/yard"

  ENV["RAILS_ENV"] = "test"
  ENV["VC_COMPAT_PATCH_ENABLED"] = "true"

  require File.expand_path("./../../demo/config/environment.rb", __dir__)
  Dir[File.expand_path("../../app/components/primer/**/*.rb", __dir__)].sort.each { |file| require file }
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

  task build: [:build_gatsby_pages, :build_gatsby_adrs, :build_lookbook_pages]

  task build_gatsby_pages: :build_yard_registry do
    require "primer/yard"

    registry = Primer::Yard::Registry.make

    require "primer/yard/legacy_gatsby_backend"
    require "primer/yard/component_manifest"

    puts "Converting YARD documentation to Markdown files."

    # Deletes docs before regenerating them, guaranteeing that we don't keep stale docs.
    components_content_glob = File.join(*%w[docs content components ** *.md])
    FileUtils.rm_rf(components_content_glob)

    manifest = Primer::Yard::ComponentManifest.where(published: true)
    backend = Primer::Yard::LegacyGatsbyBackend.new(registry, manifest)
    errors = backend.generate

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

    puts "Markdown compiled."

    # Disable autoprefixer. The legacy Gatsby docsite uses an old version that doesn't support the
    # @supports rule. Fortunately the build script that produces primer_view_components.css runs
    # a modern version of autoprefixer, so prefixing is already handled and is safe to skip during
    # the Gatsby build.
    css = File.read("docs/static/primer_view_components.css")
    css = "/* autoprefixer: off */\n#{css}"
    File.write("docs/static/primer_view_components.css", css)
    puts "Patched docs/static/primer_view_components.css"

    all_components = Primer::Component.descendants - [Primer::BaseComponent]
    components_needing_docs = all_components - Primer::Yard::ComponentManifest::COMPONENTS.keys

    if components_needing_docs.any?
      puts
      puts "The following components need docs. Care to contribute them? #{components_needing_docs.map(&:name).join(', ')}"
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
    require "primer/yard"

    FileUtils.rm_rf("previews/primer/docs/")

    registry = Primer::Yard::Registry.make

    # Generate previews from documentation examples
    Primer::Yard::ComponentManifest.all.each do |component_ref|
      component = component_ref.klass
      docs = registry.find(component)
      next unless docs.constructor&.tags(:example)&.any?

      yard_example_tags = docs.constructor.tags(:example)

      path = Pathname.new("previews/docs/#{docs.short_name.underscore}_preview.rb")
      path.dirname.mkdir unless path.dirname.exist?

      File.open(path, "w") do |f|
        f.puts("module Docs")
        f.puts("  class #{docs.short_name}Preview < ViewComponent::Preview")

        yard_example_tags.each_with_index do |tag, index|
          name, _, code = Primer::Yard::LegacyGatsbyBackend.parse_example_tag(tag)
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

  task generate_nav_redirects: :build_yard_registry do
    def join_urls(*args)
      args.map { |arg| arg.delete_prefix("/").delete_suffix("/") }.join("/")
    end

    # add to this as more pages are migrated
    INTRO_URL_MAP = {
      "/" => "https://primer.style/design/guides/development/rails",
      "/system-arguments" => "https://primer.style/view-components/lookbook/pages/system_arguments",
      "/status" => "https://primer.style/design/guides/status",
      "/migration" => "https://primer.style/design/guides/development/rails#migration-and-upgrade-guides"
    }.freeze

    STATUS_ORDER = %i[deprecated experimental alpha beta stable].freeze

    primer_design_repo_path = ENV["PRIMER_DESIGN_REPO_PATH"]
    raise "Missing PRIMER_DESIGN_REPO_PATH environment variable" unless primer_design_repo_path

    ia_component_path = File.join(primer_design_repo_path, "content", "components")
    mdx_files = Dir.glob(File.join(ia_component_path, "*.mdx"))

    nav_path = File.expand_path(File.join(*%w[.. .. docs src @primer gatsby-theme-doctocat nav.yml]), __dir__)
    nav = YAML.load_file(nav_path)
    nav_components = nav.find { |entry| entry["title"] == "Components" }["children"]

    registry = Primer::Yard::Registry.make

    results = mdx_files.filter_map do |mdx_file|
      content = File.read(mdx_file)
      front_matter_begin_idx = content.index("---")
      front_matter_end_idx = content.index("---", front_matter_begin_idx + 3)
      front_matter = YAML.load(content[0...front_matter_end_idx])
      rails_ids = front_matter["railsIds"] || []
      next if rails_ids.empty?

      # get latest status
      rails_ids.sort_by! do |id|
        status = Kernel.const_get(id).status
        STATUS_ORDER.index(status)
      end

      rails_id = rails_ids.last
      docs = registry.find(Kernel.const_get(rails_id))
      content_path = File.join(primer_design_repo_path, "content")
      mdx_path = Pathname(mdx_file).relative_path_from(content_path).to_s.chomp(".mdx")
      new_docsite_url = join_urls("https://primer.style", "design", mdx_path, "rails", docs.status_module || "stable")
      status_path = docs.status_module.nil? ? "" : "#{docs.status_module}/"
      legacy_docsite_url = "/components/#{status_path}#{docs.short_name.downcase}"

      nav_component = nav_components.find do |c|
        c["url"] == legacy_docsite_url
      end

      next unless nav_component

      nav_component["url"] = new_docsite_url
    end

    intro_nav = nav.find { |entry| entry["title"] == "Introduction" }["children"]

    INTRO_URL_MAP.each_pair do |legacy_docsite_url, new_docsite_url|
      intro_nav_entry = intro_nav.find { |n| n["url"] == legacy_docsite_url }
      next unless intro_nav_entry

      intro_nav_entry["url"] = new_docsite_url
    end

    File.write(nav_path, YAML.dump(nav))
  end

  task build_yard_registry: :init_pvc do
    require "primer/yard"

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
