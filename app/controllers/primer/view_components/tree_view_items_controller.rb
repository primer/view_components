# frozen_string_literal: true

require "json"


module Primer
  module ViewComponents
    # :nodoc:
    # :nocov:
    class TreeViewItemsController < ApplicationController
      TREE = JSON.parse(File.read(File.join(__dir__, "tree_view_items.json"))).freeze

      def index
        # delay a bit so loading spinners, etc can be seen
        sleep 1

        if params[:fail] == "true"
          head :internal_server_error and return
        end

        path =  "primer/view_components/tree_view_items/#{JSON.parse(params[:path])}"
        node = path.inject(TREE) do |current, segment|
          current["children"][segment]
        end

        entries = (
          node["children"].keys.map { |label| [label, :directory] } +
          node["files"].map { |label| [label, :file] }
        )

        entries.sort_by!(&:first)

        render(
          locals: {
            entries: entries,
            path: path,
            loader: (params[:loader] || :spinner).to_sym,
            select_variant: (params[:select_variant] || :none).to_sym
          }
        )
      end

      def async_alpha
        # delay a bit so loading spinners, etc can be seen
        sleep 1

        render(
          locals: {
            action_menu_expanded: params[:action_menu_expanded] == "true"
          }
        )
      end
    end
  end
end
