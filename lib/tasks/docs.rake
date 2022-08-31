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

  task :build do
    registry = generate_yard_registry

    puts "Converting YARD documentation to Markdown files."

    # Rails controller for rendering arbitrary ERB
    view_context = ApplicationController.new.tap { |c| c.request = ActionDispatch::TestRequest.create }.view_context
    components = [
      Primer::Beta::IconButton,
      Primer::Beta::Button,
      Primer::Alpha::Layout,
      Primer::HellipButton,
      Primer::Image,
      Primer::LocalTime,
      Primer::OcticonSymbolsComponent,
      Primer::ImageCrop,
      Primer::IconButton,
      Primer::Beta::AutoComplete,
      Primer::Beta::AutoComplete::Item,
      Primer::Beta::Avatar,
      Primer::Beta::AvatarStack,
      Primer::Beta::BaseButton,
      Primer::Beta::Blankslate,
      Primer::Beta::BorderBox,
      Primer::Beta::BorderBox::Header,
      Primer::Box,
      Primer::Beta::Breadcrumbs,
      Primer::ButtonComponent,
      Primer::Beta::ButtonGroup,
      Primer::Alpha::ButtonMarketing,
      Primer::ClipboardCopy,
      Primer::Beta::CloseButton,
      Primer::Beta::Counter,
      Primer::Beta::Details,
      Primer::Alpha::Dialog,
      Primer::Dropdown,
      Primer::DropdownMenuComponent,
      Primer::Beta::Flash,
      Primer::FlexComponent,
      Primer::FlexItemComponent,
      Primer::Beta::Heading,
      Primer::Alpha::HiddenTextExpander,
      Primer::LabelComponent,
      Primer::LayoutComponent,
      Primer::LinkComponent,
      Primer::Markdown,
      Primer::MenuComponent,
      Primer::Navigation::TabComponent,
      Primer::OcticonComponent,
      Primer::PopoverComponent,
      Primer::ProgressBarComponent,
      Primer::StateComponent,
      Primer::SpinnerComponent,
      Primer::SubheadComponent,
      Primer::TabContainerComponent,
      Primer::Beta::Text,
      Primer::Alpha::TextField,
      Primer::TimeAgoComponent,
      Primer::TimelineItemComponent,
      Primer::Tooltip,
      Primer::Truncate,
      Primer::Beta::Truncate,
      Primer::Alpha::UnderlineNav,
      Primer::Alpha::UnderlinePanels,
      Primer::Alpha::TabNav,
      Primer::Alpha::TabPanels,
      Primer::Alpha::Tooltip
    ]

    js_components = [
      Primer::Dropdown,
      Primer::LocalTime,
      Primer::ImageCrop,
      Primer::Beta::AutoComplete,
      Primer::ClipboardCopy,
      Primer::TabContainerComponent,
      Primer::TimeAgoComponent,
      Primer::Alpha::UnderlinePanels,
      Primer::Alpha::TabPanels,
      Primer::Alpha::Tooltip,
      Primer::ButtonComponent,
      Primer::IconButton,
      Primer::LinkComponent
    ]

    all_components = Primer::Component.descendants - [Primer::BaseComponent]
    components_needing_docs = all_components - components

    args_for_components = []

    errors = []

    # Deletes docs before regenerating them, guaranteeing that we don't keep stale docs.
    components_content_glob = File.join(*%w[docs content components ** *.md])
    FileUtils.rm_rf(components_content_glob)

    components.sort_by(&:name).each do |component|
      documentation = registry.get(component.name)

      data = docs_metadata(component)

      path = Pathname.new(data[:path])
      path.dirname.mkpath unless path.dirname.exist?
      File.open(path, "w") do |f|
        f.puts("---")
        f.puts("title: #{data[:title]}")
        f.puts("componentId: #{data[:component_id]}")
        f.puts("status: #{data[:status]}")
        f.puts("source: #{data[:source]}")
        f.puts("storybook: #{data[:storybook]}")
        f.puts("---")
        f.puts
        f.puts("import Example from '#{data[:example_path]}'")

        initialize_method = documentation.meths.find(&:constructor?)

        if js_components.include?(component)
          f.puts("import RequiresJSFlash from '#{data[:require_js_path]}'")
          f.puts
          f.puts("<RequiresJSFlash />")
        end

        f.puts
        f.puts("<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->")
        f.puts
        f.puts(view_context.render(inline: documentation.base_docstring))

        if documentation.tags(:deprecated).any?
          f.puts
          f.puts("## Deprecation")
          documentation.tags(:deprecated).each do |tag|
            f.puts
            f.puts view_context.render(inline: tag.text)
          end
        end

        if documentation.tags(:accessibility).any?
          f.puts
          f.puts("## Accessibility")
          documentation.tags(:accessibility).each do |tag|
            f.puts
            f.puts view_context.render(inline: tag.text)
          end
        end

        params = initialize_method.tags(:param)

        errors << { component.name => { arguments: "No argument documentation found" } } unless params.any?

        f.puts
        f.puts("## Arguments")
        f.puts
        f.puts("| Name | Type | Default | Description |")
        f.puts("| :- | :- | :- | :- |")

        documented_params = params.map(&:name)
        component_params = component.instance_method(:initialize).parameters.map { |p| p.last.to_s }

        if (documented_params & component_params).size != component_params.size
          err = { arguments: {} }
          (component_params - documented_params).each do |arg|
            err[:arguments][arg] = "Not documented"
          end

          errors << { component.name => err }
        end

        args = []
        params.each do |tag|
          default_value = pretty_default_value(tag, component)

          args << {
            "name" => tag.name,
            "type" => tag.types.join(", "),
            "default" => default_value,
            "description" => view_context.render(inline: tag.text.squish)
          }

          f.puts("| `#{tag.name}` | `#{tag.types.join(', ')}` | #{default_value} | #{view_context.render(inline: tag.text.squish)} |")
        end

        component_args = {
          "component" => data[:title],
          "source" => data[:source],
          "parameters" => args
        }

        args_for_components << component_args

        # Slots V2 docs
        slot_v2_methods = documentation.meths.select { |x| x[:renders_one] || x[:renders_many] }

        if slot_v2_methods.any?
          f.puts
          f.puts("## Slots")

          slot_v2_methods.each do |slot_documentation|
            f.puts
            f.puts("### `#{slot_documentation.name.to_s.capitalize}`")

            if slot_documentation.base_docstring.to_s.present?
              f.puts
              f.puts(view_context.render(inline: slot_documentation.base_docstring))
            end

            param_tags = slot_documentation.tags(:param)
            if param_tags.any?
              f.puts
              f.puts("| Name | Type | Default | Description |")
              f.puts("| :- | :- | :- | :- |")
            end

            param_tags.each do |tag|
              f.puts("| `#{tag.name}` | `#{tag.types.join(', ')}` | #{pretty_default_value(tag, component)} | #{view_context.render(inline: tag.text)} |")
            end
          end
        end

        errors << { component.name => { example: "No examples found" } } unless initialize_method.tags(:example).any?

        f.puts
        f.puts("## Examples")

        initialize_method.tags(:example).each do |tag|
          name, description, code = parse_example_tag(tag)
          f.puts
          f.puts("### #{name}")
          if description
            f.puts
            f.puts(view_context.render(inline: description.squish))
          end
          f.puts
          html = view_context.render(inline: code)
          f.puts("<Example src=\"#{html.tr('"', "\'").delete("\n")}\" />")
          f.puts
          f.puts("```erb")
          f.puts(code.to_s)
          f.puts("```")
        end
      end
    end

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

    File.open("static/arguments.yml", "w") do |f|
      f.puts YAML.dump(args_for_components)
    end

    # Build system arguments docs from BaseComponent
    documentation = registry.get(Primer::BaseComponent.name)
    File.open("docs/content/system-arguments.md", "w") do |f|
      f.puts("---")
      f.puts("title: System arguments")
      f.puts("---")
      f.puts
      f.puts("<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->")
      f.puts
      f.puts(documentation.base_docstring)
      f.puts

      initialize_method = documentation.meths.find(&:constructor?)

      f.puts(view_context.render(inline: initialize_method.base_docstring))
    end

    # Copy over ADR docs and insert them into the nav
    puts "Copying ADRs..."
    Rake::Task["docs:build_adrs"].invoke

    puts "Markdown compiled."

    if components_needing_docs.any?
      puts
      puts "The following components needs docs. Care to contribute them? #{components_needing_docs.map(&:name).join(', ')}"
    end
  end

  task :build_adrs do
    adr_content_dir = File.join(*%w[docs content adr])

    FileUtils.rm_rf(File.join(adr_content_dir))
    FileUtils.mkdir(adr_content_dir)

    nav_entries = Dir[File.join(*%w[adr *.md])].sort.map do |orig_path|
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

  task :preview do
    registry = generate_yard_registry

    FileUtils.rm_rf("test/previews/primer/docs/")

    components = Primer::Component.descendants

    # Generate previews from documentation examples
    components.each do |component|
      documentation = registry.get(component.name)
      short_name = component.name.gsub(/Primer|::/, "")
      initialize_method = documentation.meths.find(&:constructor?)

      next unless initialize_method&.tags(:example)&.any?

      yard_example_tags = initialize_method.tags(:example)

      path = Pathname.new("test/previews/primer/docs/#{short_name.underscore}_preview.rb")
      path.dirname.mkdir unless path.dirname.exist?

      File.open(path, "w") do |f|
        f.puts("module Primer")
        f.puts("  module Docs")
        f.puts("    class #{short_name}Preview < ViewComponent::Preview")

        yard_example_tags.each_with_index do |tag, index|
          name, _, code = parse_example_tag(tag)
          method_name = name.split("|").first.downcase.parameterize.underscore
          f.puts("      def #{method_name}; end")
          f.puts unless index == yard_example_tags.size - 1
          path = Pathname.new("test/previews/primer/docs/#{short_name.underscore}_preview/#{method_name}.html.erb")
          path.dirname.mkdir unless path.dirname.exist?
          File.open(path, "w") do |view_file|
            view_file.puts(code.to_s)
          end
        end

        f.puts("    end")
        f.puts("  end")
        f.puts("end")
      end
    end
  end

  def generate_yard_registry
    ENV["SKIP_STORYBOOK_PRELOAD"] = "1"
    require File.expand_path("./../../demo/config/environment.rb", __dir__)
    require "primer/view_components"
    require "yard/docs_helper"
    require "view_component/test_helpers"
    include ViewComponent::TestHelpers
    include Primer::ViewHelper
    include YARD::DocsHelper

    Dir["./app/components/primer/**/*.rb"].sort.each { |file| require file }

    YARD::Rake::YardocTask.new

    # Custom tags for yard
    YARD::Tags::Library.define_tag("Accessibility", :accessibility)
    YARD::Tags::Library.define_tag("Deprecation", :deprecation)
    YARD::Tags::Library.define_tag("Parameter", :param, :with_types_name_and_default)

    puts "Building YARD documentation."
    Rake::Task["yard"].execute

    registry = YARD::RegistryStore.new
    registry.load!(".yardoc")
    registry
  end

  def parse_example_tag(tag)
    name = tag.name
    description = nil
    code = nil

    if tag.text.include?("@description")
      splitted = tag.text.split(/@description|@code/)
      description = splitted.second.gsub(/^[ \t]{2}/, "").strip
      code = splitted.last.gsub(/^[ \t]{2}/, "").strip
    else
      code = tag.text
    end

    [name, description, code]
  end

  def pretty_default_value(tag, component)
    params = tag.object.parameters.find { |param| [tag.name.to_s, "#{tag.name}:"].include?(param[0]) }
    default = tag.defaults&.first || params&.second

    return "N/A" unless default

    constant_name = "#{component.name}::#{default}"
    constant_value = default.safe_constantize || constant_name.safe_constantize

    return pretty_value(default) if constant_value.nil?

    pretty_value(constant_value)
  end

  def docs_metadata(component)
    (status_module, short_name) = status_module_and_short_name(component)
    status_path = status_module.nil? ? "" : "#{status_module}/"
    status = component.status.to_s

    {
      title: short_name,
      component_id: short_name.underscore,
      status: status.capitalize,
      source: source_url(component),
      storybook: storybook_url(component),
      path: "docs/content/components/#{status_path}#{short_name.downcase}.md",
      example_path: example_path(component),
      require_js_path: require_js_path(component)
    }
  end

  def source_url(component)
    path = component.name.split("::").map(&:underscore).join("/")

    "https://github.com/primer/view_components/tree/main/app/components/#{path}.rb"
  end

  def storybook_url(component)
    path = component.name.split("::").map { |n| n.underscore.dasherize }.join("-")

    "https://primer.style/view-components/stories/?path=/story/#{path}"
  end

  def example_path(component)
    example_path = "../../src/@primer/gatsby-theme-doctocat/components/example"
    example_path = "../#{example_path}" if status_module?(component)
    example_path
  end

  def require_js_path(component)
    require_js_path = "../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash"
    require_js_path = "../#{require_js_path}" if status_module?(component)
    require_js_path
  end

  def status_module?(component)
    (%w[Alpha Beta] & component.name.split("::")).any?
  end
end
