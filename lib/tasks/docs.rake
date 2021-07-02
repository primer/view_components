# frozen_string_literal: true

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
      Primer::HellipButton,
      Primer::Image,
      Primer::LocalTime,
      Primer::OcticonSymbolsComponent,
      Primer::ImageCrop,
      Primer::IconButton,
      Primer::AutoComplete,
      Primer::AutoComplete::Item,
      Primer::AvatarComponent,
      Primer::AvatarStackComponent,
      Primer::BaseButton,
      Primer::BlankslateComponent,
      Primer::BorderBoxComponent,
      Primer::BoxComponent,
      Primer::BreadcrumbComponent,
      Primer::ButtonComponent,
      Primer::ButtonGroup,
      Primer::Alpha::ButtonMarketing,
      Primer::ClipboardCopy,
      Primer::CloseButton,
      Primer::CounterComponent,
      Primer::DetailsComponent,
      Primer::Dropdown,
      Primer::DropdownMenuComponent,
      Primer::FlashComponent,
      Primer::FlexComponent,
      Primer::FlexItemComponent,
      Primer::HeadingComponent,
      Primer::HiddenTextExpander,
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
      Primer::TabNavComponent,
      Primer::Beta::Text,
      Primer::TimeAgoComponent,
      Primer::TimelineItemComponent,
      Primer::Tooltip,
      Primer::Truncate,
      Primer::UnderlineNavComponent
    ]

    js_components = [
      Primer::Dropdown,
      Primer::LocalTime,
      Primer::ImageCrop,
      Primer::AutoComplete,
      Primer::ClipboardCopy,
      Primer::TabContainerComponent,
      Primer::TabNavComponent,
      Primer::TimeAgoComponent,
      Primer::UnderlineNavComponent
    ]

    all_components = Primer::Component.descendants - [Primer::BaseComponent]
    components_needing_docs = all_components - components

    args_for_components = []
    classes_found_in_examples = []

    errors = []

    components.each do |component|
      documentation = registry.get(component.name)

      # Primer::AvatarComponent => Avatar
      short_name = component.name.gsub(/Primer|::|Component/, "")

      path = Pathname.new("docs/content/components/#{short_name.downcase}.md")
      path.dirname.mkdir unless path.dirname.exist?
      File.open(path, "w") do |f|
        f.puts("---")
        f.puts("title: #{short_name}")
        f.puts("status: #{component.status.to_s.capitalize}")
        f.puts("source: https://github.com/primer/view_components/tree/main/app/components/primer/#{component.to_s.demodulize.underscore}.rb")
        f.puts("storybook: https://primer.style/view-components/stories/?path=/story/primer-#{short_name.underscore.dasherize}-component")
        f.puts("---")
        f.puts
        f.puts("import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'")

        initialize_method = documentation.meths.find(&:constructor?)

        if js_components.include?(component)
          f.puts("import RequiresJSFlash from '../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'")
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

        docummented_params = params.map(&:name)
        component_params = component.instance_method(:initialize).parameters.map { |p| p.last.to_s }

        if (docummented_params & component_params).size != component_params.size
          err = { arguments: {} }
          (component_params - docummented_params).each do |arg|
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
          "component" => short_name,
          "source" => "https://github.com/primer/view_components/tree/main/app/components/primer/#{component.to_s.demodulize.underscore}.rb",
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

            if slot_documentation.base_docstring.present?
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

          f.puts
          f.puts("### #{name}")
          if description
            f.puts
            f.puts(description)
          end
          f.puts
          html = view_context.render(inline: code)
          html.scan(/class="([^"]*)"/) do |classnames|
            classes_found_in_examples.concat(classnames[0].split(" ").reject { |c| c.starts_with?("octicon", "js", "my-") }.map { ".#{_1}"})
          end
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

    File.open("static/classes.yml", "w") do |f|
      f.puts YAML.dump(classes_found_in_examples.sort.uniq)
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

    puts "Markdown compiled."

    if components_needing_docs.any?
      puts
      puts "The following components needs docs. Care to contribute them? #{components_needing_docs.map(&:name).join(', ')}"
    end
  end

  task :preview do
    registry = generate_yard_registry

    FileUtils.rm_rf("demo/test/components/previews/primer/docs/")

    components = Primer::Component.descendants

    # Generate previews from documentation examples
    components.each do |component|
      documentation = registry.get(component.name)
      short_name = component.name.gsub(/Primer|::/, "")
      initialize_method = documentation.meths.find(&:constructor?)

      next unless initialize_method.tags(:example).any?

      yard_example_tags = initialize_method.tags(:example)

      path = Pathname.new("demo/test/components/previews/primer/docs/#{short_name.underscore}_preview.rb")
      path.dirname.mkdir unless path.dirname.exist?

      File.open(path, "w") do |f|
        f.puts("module Primer")
        f.puts("  module Docs")
        f.puts("    class #{short_name}Preview < ViewComponent::Preview")

        yard_example_tags.each_with_index do |tag, index|
          method_name = tag.name.split("|").first.downcase.parameterize.underscore
          f.puts("      def #{method_name}; end")
          f.puts unless index == yard_example_tags.size - 1
          path = Pathname.new("demo/test/components/previews/primer/docs/#{short_name.underscore}_preview/#{method_name}.html.erb")
          path.dirname.mkdir unless path.dirname.exist?
          File.open(path, "w") do |view_file|
            view_file.puts(tag.text.to_s)
          end
        end

        f.puts("    end")
        f.puts("  end")
        f.puts("end")
      end
    end
  end

  def generate_yard_registry
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

  def pretty_default_value(tag, component)
    params = tag.object.parameters.find { |param| [tag.name.to_s, tag.name.to_s + ":"].include?(param[0]) }
    default = tag.defaults&.first || params&.second

    return "N/A" unless default

    constant_name = "#{component.name}::#{default}"
    constant_value = default.safe_constantize || constant_name.safe_constantize

    return pretty_value(default) if constant_value.nil?

    pretty_value(constant_value)
  end
end
