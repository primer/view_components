module Primer
  class TabNavComponentPreview < ViewComponent::Preview
    def default
      render(Primer::TabNavComponent.new(with_panel: true)) do |c|
        c.tab(selected: true) do |t|
          t.panel { "Panel 1" }
          t.title { "Tab 1" }
        end
        c.tab do |t|
          t.panel { "Panel 2" }
          t.title { "Tab 2" }
        end
        c.tab do |t|
          t.panel { "Panel 3" }
          t.title { "Tab 3" }
        end
      end
    end
  end
end
