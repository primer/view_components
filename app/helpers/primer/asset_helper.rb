# frozen_string_literal: true

module Primer
  # :nocov:
  # :nodoc:
  module AssetHelper
    def pvc_stylesheet_link_tags
      # rubocop:disable Style/ClassVars
      @@pvc_stylesheet_link_tags ||= "<!-- pvc_stylesheet_link_tags -->".html_safe
      # rubocop:enable Style/ClassVars
    end
  end
end
