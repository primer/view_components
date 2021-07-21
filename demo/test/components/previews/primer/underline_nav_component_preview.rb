module Primer
  class UnderlineNavComponentPreview < ViewComponent::Preview
    def default
      render(Primer::UnderlineNavComponent.new(label: "Test navigation", with_panel: true)) do |c|
        c.tab(selected: true, id: "tab-1", panel_id: "panel-1") do |t|
          t.panel { "Panel 1" }
          t.text { "Tab 1" }
        end
        c.tab(id: "tab-2", panel_id: "panel-2") do |t|
          t.panel { "Panel 2" }
          t.text { "Tab 2" }
        end
        c.tab(id: "tab-3", panel_id: "panel-3") do |t|
          t.panel { "Panel 3" }
          t.text { "Tab 3" }
        end
      end
    end
  end
end
