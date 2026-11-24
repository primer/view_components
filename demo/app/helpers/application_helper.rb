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

  def color_theme_attributes(theme = "light")
    theme = color_themes.include?(theme) ? theme : "light"
    mode = theme.include?("dark") ? "dark" : "light"

    attributes = {
      "data-color-mode": mode,
      "data-#{mode}-theme": theme
    }

    tag_attributes(attributes)
  end

  def markdown_task_list_ids_for_theme(content, theme)
    return content unless content.include?('aria-labelledby="unordered-task-list-label"')

    # The layout repeats rendered HTML, so the fixture's IDs need a suffix per copy.
    content.gsub(/(?<attribute>\s(?:id|for|aria-labelledby)=")(?<id>(?:unordered|mixed)-task-list-label|checkbox-[1-5])"/) do
      %(#{Regexp.last_match(:attribute)}#{Regexp.last_match(:id)}-#{theme}")
    end.html_safe
  end

  def tag_attributes(hash)
    parts = hash.map do |key, value|
      safe_join([key, "=", value])
    end

    safe_join(parts, " ")
  end
end
