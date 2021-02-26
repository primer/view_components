class TabNavComponentPreview < ViewComponent::Preview
  def default
    render(Primer::TabNavComponent.new(with_panel: true)) do |c|
      c.tab(selected: true, title: "Tab 1") { "Panel 1" }
      c.tab(title: "Tab 2") { "Panel 2" }
      c.tab(title: "Tab 3") { "Panel 3" }
    end
  end
end
