# frozen_string_literal: true

class Primer::ClipboardCopyStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:clipboard_copy_simple) do
    controls do
      text(:value, "Text to copy")
    end

    content do
      "Click to copy!"
    end
  end

  story(:clipboard_copy_with_target) do
    controls do
      text(:id, "id")
      text(:classes, "btn btn-sm")
    end

    content do |component|
      component.target do
        "Text to copy"
      end

      "Click to copy!"
    end
  end

  story(:clipboard_copy_with_form_target) do
    controls do
      text(:id, "id")
      text(:classes, "btn btn-sm")
    end

    content do |component|
      component.target(tag: :input, value: "Text to copy")

      "Click to copy!"
    end
  end

  story(:clipboard_copy_with_link_target) do
    controls do
      text(:id, "id")
      text(:classes, "btn btn-sm")
    end

    content do |component|
      component.target(tag: :a, href: "/path/to/copy") do
        "Link whos href will be copied"
      end

      "Click to copy!"
    end
  end
end
