module Primer
  class TabNavComponentPreview < ViewComponent::Preview
    def default
      render(Primer::TabNavComponent.new(with_panel: true)) do |c|
        c.tab(selected: true) do |t|
          t.panel { "Panel 1" }
          "Tab 1"
        end
        c.tab do |t|
          t.panel { "Panel 2" }
          "Tab 2"
        end
        c.tab do |t|
          t.panel { "Panel 3" }
          "Tab 3"
        end
      end
    end
  end
end
