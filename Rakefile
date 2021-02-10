# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "yard"
require "yard/renders_one_handler"
require "yard/renders_many_handler"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

Rake::TestTask.new(:bench) do |t|
  t.libs << "test"
  t.test_files = FileList["test/benchmarks/**/bench_*.rb"]
  t.verbose = true
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

  def one_of(enumerable)
    values =
      case enumerable
      when Hash
        enumerable.map do |key, value|
          "#{pretty_value(key)} (#{pretty_value(value)})"
        end
      else
        enumerable.map do |key|
          pretty_value(key)
        end
      end

    "One of #{values.to_sentence(last_word_connector: ', or ')}."
  end

  def link_to_system_arguments_docs
    "[System arguments](/system-arguments)"
  end

  def link_to_component(component)
    short_name = component.name.demodulize.gsub("Component", "")
    "[#{short_name}](/components/#{short_name.downcase})"
  end

  def pretty_value(val)
    case val
    when nil
      "`nil`"
    when Symbol
      "`:#{val}`"
    else
      "`#{val}`"
    end
  end

  task :build do
    require File.expand_path("demo/config/environment.rb", __dir__)
    require "primer/view_components"
    require "view_component/test_helpers"
    include ViewComponent::TestHelpers

    puts "Building YARD documentation."
    Rake::Task["yard"].execute

    puts "Converting YARD documentation to Markdown files."

    # Rails controller for rendering arbitrary ERB
    view_context = ApplicationController.new.tap { |c| c.request = ActionDispatch::TestRequest.create }.view_context

    registry = YARD::RegistryStore.new
    registry.load!(".yardoc")
    components = [
      Primer::AvatarComponent,
      Primer::BlankslateComponent,
      Primer::BorderBoxComponent,
      Primer::BoxComponent,
      Primer::BreadcrumbComponent,
      Primer::ButtonComponent,
      Primer::ButtonGroupComponent,
      Primer::ButtonMarketingComponent,
      Primer::CounterComponent,
      Primer::DetailsComponent,
      Primer::DropdownComponent,
      Primer::DropdownMenuComponent,
      Primer::FlashComponent,
      Primer::FlexComponent,
      Primer::FlexItemComponent,
      Primer::HeadingComponent,
      Primer::LabelComponent,
      Primer::LayoutComponent,
      Primer::LinkComponent,
      Primer::OcticonComponent,
      Primer::PopoverComponent,
      Primer::ProgressBarComponent,
      Primer::StateComponent,
      Primer::SpinnerComponent,
      Primer::SubheadComponent,
      Primer::TextComponent,
      Primer::TimelineItemComponent,
      Primer::TooltipComponent,
      Primer::TruncateComponent,
      Primer::UnderlineNavComponent
    ]

    all_components = Primer::Component.descendants - [Primer::BaseComponent]
    components_needing_docs = all_components - components

    components_without_examples = []

    components.each do |component|
      documentation = registry.get(component.name)

      # Primer::AvatarComponent => Avatar
      short_name = component.name.demodulize.gsub("Component", "")

      File.open("docs/content/components/#{short_name.downcase}.md", "w") do |f|
        f.puts("---")
        f.puts("title: #{short_name}")
        f.puts("status: #{component.status.to_s.capitalize}")
        f.puts("source: https://github.com/primer/view_components/tree/main/app/components/primer/#{component.to_s.demodulize.underscore}.rb")
        f.puts("---")
        f.puts
        f.puts("<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->")
        f.puts
        f.puts(view_context.render(inline: documentation.base_docstring))
        f.puts

        initialize_method = documentation.meths.find(&:constructor?)

        if initialize_method.tags(:example).any?
          f.puts("## Examples")
          f.puts
        else
          components_without_examples << component
        end

        initialize_method.tags(:example).each do |tag|
          iframe_height = tag.name.split("|").first
          name = tag.name.split("|")[1]
          description = tag.name.split("|")[2]

          f.puts("### #{name}")
          if description
            f.puts
            f.puts(description)
          end
          f.puts
          html = view_context.render(inline: tag.text)

          f.puts("<iframe style=\"width: 100%; border: 0px; height: #{iframe_height}px;\" srcdoc=\"<html><head><link href=\'https://unpkg.com/@primer/css/dist/primer.css\' rel=\'stylesheet\'></head><body>#{html.tr('"', "\'").delete("\n")}</body></html>\"></iframe>")
          f.puts
          f.puts("```erb")
          f.puts(tag.text.to_s)
          f.puts("```")
          f.puts
        end

        f.puts("## Arguments")
        f.puts
        f.puts("| Name | Type | Default | Description |")
        f.puts("| :- | :- | :- | :- |")

        initialize_method.tags(:param).each do |tag|
          params = tag.object.parameters.find { |param| [tag.name.to_s, tag.name.to_s + ":"].include?(param[0]) }

          default =
            if params && params[1]
              constant_name = "#{component.name}::#{params[1]}"
              constant_value = constant_name.safe_constantize
              if constant_value.nil?
                pretty_value(params[1])
              else
                pretty_value(constant_value)
              end
            else
              "N/A"
            end

          f.puts("| `#{tag.name}` | `#{tag.types.join(', ')}` | #{default} | #{view_context.render(inline: tag.text)} |")
        end

        # Slots V2 docs
        slot_v2_methods = documentation.meths.select { |x| x[:renders_one] || x[:renders_many] }

        if slot_v2_methods.any?
          f.puts
          f.puts("## Slots")

          slot_v2_methods.each do |slot_documentation|
            f.puts
            f.puts("### `#{slot_documentation.name.to_s.capitalize}`")
            f.puts

            if slot_documentation.base_docstring.present?
              f.puts(slot_documentation.base_docstring)
              f.puts
            end

            f.puts("| Name | Type | Default | Description |")
            f.puts("| :- | :- | :- | :- |")

            slot_documentation.tags(:param).each do |tag|
              params = tag.object.parameters.find { |param| [tag.name.to_s, tag.name.to_s + ":"].include?(param[0]) }

              default =
                if params && params[1]
                  "`#{params[1]}`"
                else
                  "N/A"
                end

              f.puts("| `#{tag.name}` | `#{tag.types.join(', ')}` | #{default} | #{view_context.render(inline: tag.text)} |")
            end
          end
        end

        # Slots V1 docs
        next unless component.respond_to?(:slots)

        component.slots.each do |name, value|
          slot_documentation = registry.get("#{component.name}::#{value[:class_name]}")

          next unless slot_documentation

          slot_initialize_method = slot_documentation.meths.find(&:constructor?)

          f.puts
          f.puts("### `#{name}` slot")
          f.puts
          f.puts("| Name | Type | Default | Description |")
          f.puts("| :- | :- | :- | :- |")

          slot_initialize_method.tags(:param).each do |tag|
            params = tag.object.parameters.find { |param| [tag.name.to_s, tag.name.to_s + ":"].include?(param[0]) }

            default =
              if params && params[1]
                "`#{params[1]}`"
              else
                "N/A"
              end

            f.puts("| `#{tag.name}` | `#{tag.types.join(', ')}` | #{default} | #{view_context.render(inline: tag.text)} |")
          end

          if slot_documentation.base_docstring.present?
            f.puts
            f.puts(slot_documentation.base_docstring)
          end
        end
      end
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

      f.puts("## Arguments")
      f.puts
      f.puts("| Name | Type | Description |")
      f.puts("| :- | :- | :- |")

      initialize_method.tags(:param).each do |tag|
        f.puts("| `#{tag.name}` | `#{tag.types.join(', ')}` | #{view_context.render(inline: tag.text)} |")
      end
    end

    puts "Markdown compiled."

    if components_without_examples.any?
      puts
      puts "The following components have no examples defined: #{components_without_examples.map(&:name).join(', ')}. Consider adding an example?"
    end

    if components_needing_docs.any?
      puts
      puts "The following components needs docs. Care to contribute them? #{components_needing_docs.map(&:name).join(', ')}"
    end
  end
end

task default: :test
