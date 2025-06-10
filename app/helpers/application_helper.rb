# frozen_string_literal: true
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
  def color_theme_attributes(theme = "light")
    theme = color_themes.include?(theme) ? theme : "light"
    mode = theme.include?("dark") ? "dark" : "light"
    attributes = {
      "data-color-mode": mode,
      "data-#{mode}-theme": theme
    }
    tag_attributes(attributes)
  end
  def tag_attributes(hash)
    parts = hash.map do |key, value|
      safe_join([key, "=", value])
    end
    safe_join(parts, " ")
  end
end