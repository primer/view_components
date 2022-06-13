# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Alpha
  # @label ActionMenu
  class ActionMenuPreview < ViewComponent::Preview
    # @label Playground
    # @param string_example text
    # @param boolean_example toggle
    # @param email_example email
    # @param number_example number
    # @param url_example url
    # @param tel_example tel
    # @param textarea_example textarea
    # @param select_example select [one, two, three]
    # @param select_custom_labels select [[One label, one], [Two label, two], [Three label, three]]
    # With empty option (`~` in YAML)
    # @param select_empty_option select [~, one, two, three]
    def playground(string_example: "Default value", boolean_example: false, select_example: :one)
      render(Primer::Alpha::ActionMenu.new(menu_id: "my-action-menu-0")) do |c|
        c.trigger { "Menu" }
        c.item(tag: :a, href: "https://primer.style/design/") do
          "Primer Design"
        end
        c.item(tag: :button, type: "button", onclick: "() => {}") do
          "Quote Reply"
        end
        c.item(tag: :"clipboard-copy", value: "Text to copy") do
          "Copy Text"
        end
      end
    end
    end
  end
