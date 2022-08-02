# frozen_string_literal: true

# no doc
module ApplicationHelper
  def color_themes
    %w[
      light
      light_colorblind
      light_high_contrast
      dark
      dark_dimmed
      dark_high_contrast
      dark_colorblind
    ]
  end

  def color_theme_attributes(theme = nil)
    theme = "light" if color_themes.nil?

    attributes = {
      "data-color-mode": theme.start_with?("dark") ? "dark" : "light",
      "data-light-theme": color_themes.include?(theme) ? theme : "light",
      "data-dark-theme": color_themes.include?(theme) ? theme : "dark"
    }

    tag_attributes(attributes)
  end

  def tag_attributes(hash)
    parts = hash.map do |key, value|
      safe_join([
        key,
        "=",
        value
      ])
    end

    safe_join(parts, " ")
  end
end
