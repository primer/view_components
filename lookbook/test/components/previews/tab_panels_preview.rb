# frozen_string_literal: true

# no doc
class TabPanelsPreview < ViewComponent::Preview
  def default
    render(Primer::Alpha::TabPanels.new(label: "label")) do |c|
      c.tab(selected: true, id: "tab-1") do |t|
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
