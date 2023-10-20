# frozen_string_literal: true

module Primer
  module ViewComponents
    # :nodoc:
    class AssetInjectionMiddleware
      def initialize(app)
        @app = app
      end

      def call(env)
        env["rendered_view_component_classes"] = Set.new

        @app.call(env).tap do |response|
          _, _, rails_response = response

          if rails_response.is_a?(ActionDispatch::Response::RackBody)
            helpers = env["action_controller.instance"].helpers

            link_tags = env["rendered_view_component_classes"].flat_map do |component_class|
              asset_tag_map[component_class] ||= begin
                # sidecar_files also returns .pcss files for some reason
                sidecar_css_files = component_class.sidecar_files(["css"]).select { |f| File.extname(f) == ".css" }

                sidecar_css_files.map do |sidecar_css_file|
                  # TODO: refactor to use Rails.application.assets.find_asset or similar mechanism
                  sidecar_asset = File.basename(sidecar_css_file).chomp(".css")
                  helpers.stylesheet_link_tag("primer_view_components/#{sidecar_asset}")
                end
              end
            end

            rails_response.body.sub!("<!-- pvc_stylesheet_link_tags -->", link_tags.join)
          end
        end
      end

      private

      def asset_tag_map
        @asset_tag_map ||= {}
      end
    end
  end
end
