# frozen_string_literal: true

require "pathname"
require "yaml"

namespace :legacy do
  task generate_redirects: ["docs:build_yard_registry"] do
    def join_urls(*args)
      args.map { |arg| arg.delete_prefix("/").delete_suffix("/") }.join("/")
    end

    primer_design_repo_path = ENV["PRIMER_DESIGN_REPO_PATH"]
    raise 'Missing PRIMER_DESIGN_REPO_PATH environment variable' unless primer_design_repo_path

    ia_component_path = File.join(primer_design_repo_path, "content", "components")
    mdx_files = Dir.glob(File.join(ia_component_path, "*.mdx"))

    registry ||= Primer::Yard::Registry.make

    mdx_files.each do |mdx_file|
      content = File.read(mdx_file)
      front_matter_begin_idx = content.index("---")
      front_matter_end_idx = content.index("---", front_matter_begin_idx + 3)
      front_matter = YAML.load(content[0...front_matter_end_idx]) rescue binding.irb
      rails_id = front_matter["railsId"]
      next unless rails_id

      content_path = File.join(primer_design_repo_path, "content")
      mdx_path = Pathname(mdx_file).relative_path_from(content_path).to_s.chomp(".mdx")
      new_docsite_url = join_urls("design", mdx_path)
      docs = registry.find(Kernel.const_get(rails_id))
      status_path = docs.status_module.nil? ? "" : "#{docs.status_module}/"
      legacy_docsite_url = "components/#{status_path}#{docs.short_name.downcase}"

      puts(<<~XML)
        <rule name="ViewComponents docs for #{rails_id}" stopProcessing="true">
          <match url="^view-components/#{legacy_docsite_url}" ignoreCase="true" />
          <action type="Redirect" redirectType="Permanent" url="/#{new_docsite_url}" />
        </rule>
      XML
    end
  end
end
