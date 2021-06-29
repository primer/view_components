module Primer
  class TabNavComponentPreview < ViewComponent::Preview
    def default
      render(Primer::TabNavComponent.new(label: "label", with_panel: true)) do |c|
        c.tab(id: "tab-1", selected: true) do |t|
          t.panel { "Panel 1" }
          t.text { "Tab 1" }
        end
        c.tab(id: "tab-2") do |t|
          t.panel { "Panel 2" }
          t.text { "Tab 2" }
        end
        c.tab(id: "tab-3") do |t|
          t.panel { "Panel 3" }
          t.text { "Tab 3" }
        end
      end
    end
  end
end
