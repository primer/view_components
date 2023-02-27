# frozen_string_literal: true

namespace :static do
  task dump: [:dump_statuses, :dump_constants, :dump_audited_at, :dump_previews, :dump_arguments]

  task dump_statuses: :init_pvc do
    Primer::ViewComponents.dump(:statuses)
  end

  task dump_constants: :init_pvc do
    Primer::ViewComponents.dump(:constants)
  end

  task dump_audited_at: :init_pvc do
    Primer::ViewComponents.dump(:audited_at)
  end

  task dump_previews: :init_pvc do
    require "json"

    previews = Lookbook.previews.filter_map do |preview|
      next if preview.preview_class.name.start_with?("Docs::")
      next if preview.preview_class == Primer::Forms::FormsPreview

      component = preview.components.first&.component_class

      unless component
        raise "Could not determine which component `#{preview.preview_class}` is designed to preview. Please add a `@component` annotation."
      end

      _, _, class_name = Primer::Yard::DocsHelper.status_module_and_short_name(component)

      {
        name: preview.name,
        component: class_name,
        status: component.status.to_s,
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

    File.open(File.join(Primer::ViewComponents::DEFAULT_STATIC_PATH, "previews.json"), "w") do |f|
      f.write(JSON.pretty_generate(previews))
      f.write($INPUT_RECORD_SEPARATOR)
    end
  end

  task dump_arguments: "docs:build_yard_registry" do
    require "json"

    registry = Primer::Yard::Registry.make

    view_context = ApplicationController.new.tap { |c| c.request = ActionDispatch::TestRequest.create }.view_context.tap do |vc|
      vc.singleton_class.include(Primer::Yard::DocsHelper)
      vc.singleton_class.include(Primer::ViewHelper)
    end

    arguments = Primer::Component.descendants.sort_by(&:name).map do |component|
      docs = registry.find(component)
      ref = Primer::Yard::ComponentManifest.ref_for(component)

      args = docs.params.map do |tag|
        default_value = Primer::Yard::DocsHelper.pretty_default_value(tag, component)

        {
          "name" => tag.name,
          "type" => tag.types.join(", "),
          "default" => default_value,
          "description" => view_context.render(inline: tag.text.squish)
        }
      end

      {
        "component" => docs.metadata[:title],
        "status" => component.status.to_s,
        "source" => ref.source_url,
        "lookbook" => ref.lookbook_url,
        "parameters" => args
      }
    end

    File.open(File.join(Primer::ViewComponents::DEFAULT_STATIC_PATH, "arguments.json"), "w") do |f|
      f.write(JSON.pretty_generate(arguments))
    end
  end
end
