# frozen_string_literal: true

require_relative "./test_helper"
Dir["app/components/**/*.rb"].each { |file| require_relative "../../#{file}" }

# rubocop:disable Style/WordArray
IGNORED_SELECTORS = {
  :global => ["preview-wrap"],
  Primer::Alpha::TabNav => ["octicon", "octicon-bookmark", "octicon-heart", "octicon-star"],
  Primer::Alpha::ActionList => ["ActionList-sectionDivider", "ActionList-sectionDivider-title", "ActionListContent--visual16", "ActionListItem--hasSubItem", "ActionListWrap--subGroup", "ActionListContent--sizeLarge", "ActionListContent--sizeXLarge", "octicon", "octicon-star", "Button--medium", "ActionListItem--trailingActionHover", "ActionListItem--danger", "ActionListItem--navActive"],
  Primer::Alpha::AutoComplete => [/.*/],
  Primer::Alpha::Banner => ["Banner-message", "Banner-title", "Banner-visual", "flash", "octicon", "octicon-bell", "Banner-actions", "Button--medium", "Banner--error", "Banner--success", "Banner--warning", "Banner--full"],
  Primer::Alpha::Dialog => ["Button--medium", "Overlay", "Overlay--hidden", "Overlay--motion-scaleFade", "Overlay--size-medium", "Overlay-actionWrap", "Overlay-backdrop--center", "Overlay-body", "Overlay-closeButton", "Overlay-footer", "Overlay-footer--alignEnd", "Overlay-footer--divided", "Overlay-header", "Overlay-headerContentWrap", "Overlay-title", "Overlay-titleWrap", "Overlay-whenNarrow", "btn", "btn-primary", "close-button", "octicon", "octicon-x"],
  Primer::Alpha::HiddenTextExpander => ["ellipsis-expander", "hidden-text-expander"],
  Primer::Alpha::Layout => ["Layout--sidebarPosition-flowRow-start", "Layout--sidebarPosition-start", "Layout--flowRow-until-lg", "Layout--flowRow-until-md", "Layout--gutter-condensed", "Layout--gutter-none", "Layout--gutter-spacious", "Layout--sidebar-narrow", "Layout--sidebar-wide", "Layout--sidebarPosition-end", "Layout--sidebarPosition-flowRow-end", "Layout--sidebarPosition-flowRow-none", "Layout-main-centered-lg", "Layout-main-centered-md", "Layout-main-centered-xl"],
  Primer::Alpha::Menu => ["octicon", "octicon-check"],
  Primer::Alpha::NavList => ["ActionList-sectionDivider", "ActionList-sectionDivider-title", "ActionListItem--hasSubItem", "ActionListWrap--subGroup", "ActionList", "ActionList--subGroup", "ActionListContent--hasActiveSubItem", "ActionListContent--visual16", "ActionListItem--navActive", "ActionListItem--subItem", "ActionListItem-collapseIcon", "octicon", "octicon-chevron-down", "octicon-comment-discussion", "octicon-gear", "octicon-people", "Button--medium"],
  Primer::Alpha::SegmentedControl => ["Button--invisible-noVisuals", "Button--medium", "SegmentedControl-item--selected", "octicon", "octicon-eye", "octicon-file-code", "octicon-people", "SegmentedControl--iconOnly", "btn-block"],
  Primer::Alpha::TabPanels => ["tabnav", "tabnav-tab", "tabnav-tabs"],
  Primer::Alpha::TextField => ["FormControl", "octicon"],
  Primer::Alpha::ToggleSwitch => ["octicon", "octicon-alert", "ToggleSwitch--checked", "ToggleSwitch--disabled", "ToggleSwitch--small"],
  Primer::Alpha::Tooltip => ["Button--medium", "octicon", "octicon-search"],
  Primer::Alpha::UnderlineNav => ["UnderlineNav", "UnderlineNav-actions", "UnderlineNav-body", "UnderlineNav-item", "btn", "octicon", "octicon-star"],
  Primer::Alpha::UnderlinePanels => ["UnderlineNav", "UnderlineNav-body", "UnderlineNav-item"],
  Primer::Beta::AutoComplete => ["ActionList", "FormControl", "FormControl-input", "FormControl-input-leadingVisual", "FormControl-input-leadingVisualWrap", "FormControl-input-wrap", "FormControl-input-wrap--leadingVisual", "FormControl-label", "FormControl-medium", "Overlay", "Overlay--height-auto", "Overlay--width-auto", "Overlay-backdrop--anchor", "Overlay-body", "Overlay-body--paddingNone", "octicon", "octicon-search", "btn", "btn-primary"],
  Primer::Beta::Avatar => ["avatar"],
  Primer::Beta::AvatarStack => ["AvatarStack", "AvatarStack-body", "avatar", "avatar-small", "tooltipped", "tooltipped-n"],
  Primer::Beta::Blankslate => ["Button--medium", "btn", "btn-primary", "octicon", "octicon-shield", "Box"],
  Primer::Beta::Breadcrumbs => ["breadcrumb-item-selected"],
  Primer::Beta::BorderBox => ["Box", "Box-body", "Box-footer", "Box-header", "Box-row"],
  Primer::Beta::Button => ["Button--medium", "octicon", "octicon-search", "Button--invisible-noVisuals"],
  Primer::Beta::ButtonGroup => ["BtnGroup", "BtnGroup-item", "btn", "btn-danger", "btn-outline", "btn-primary"],
  Primer::Beta::CloseButton => ["close-button", "octicon", "octicon-x"],
  Primer::Beta::Details => ["details-overlay", "btn"],
  Primer::Beta::Flash => ["flash", "octicon", "octicon-people"],
  Primer::Beta::IconButton => ["Button--medium", "octicon", "octicon-x"],
  Primer::Beta::Truncate => ["Truncate-text"],
  Primer::Beta::ClipboardCopy => ["octicon", "octicon-check", "octicon-copy"],
  Primer::Beta::Octicon => ["octicon"],
  Primer::Alpha::Dropdown => ["btn", "details-overlay", "details-reset", "dropdown-menu-se", "octicon", "octicon-triangle-down"],
  Primer::Beta::Markdown => ["markdown-body"],
  Primer::Beta::Subhead => ["Button--medium"],
  Primer::Beta::TimelineItem => ["octicon", "octicon-check"]
}.freeze
# rubocop:enable Style/WordArray

# Test CSS Selectors Used By Components
# ----
#
# ensure all of the classes used by components are valid, checking against the
# available selectors in component-specific CSS
class ComponentSelectorUseTest < Minitest::Test
  include Primer::ComponentTestHelpers
  include Primer::RenderPreview

  COMPONENT_SELECTORS = Dir["app/{components,lib/primer}/**/*.css.json"].map do |file|
    data = JSON.parse(File.read(file))
    data["selectors"].map { |sel| sel.gsub('\n', "").strip }
  end.flatten.uniq

  # these test methods are created dynamically so we can see all failures for
  # all components and not error after the first component failure
  Primer::Component.descendants.each do |component_class|
    class_test_name = component_class.name.downcase.gsub("::", "_")
    define_method("test_selectors_used_by_#{class_test_name}_are_valid") do
      preview_class = get_preview_class(component_class)
      next unless preview_class

      unmatched_selectors = []
      previews = preview_class.instance_methods(false)
      previews.each do |preview|
        preview_page = render_preview(preview, preview_klass: preview_class)
        preview_selectors = find_selectors(component_class, preview_page).map { |sel| ".#{sel}" }

        unmatched_selectors << (preview_selectors - COMPONENT_SELECTORS)
      end
      unmatched_selectors = unmatched_selectors.flatten.compact.uniq

      assert unmatched_selectors.empty?, unmatched_selectors_message(component_class, unmatched_selectors)
    end
  end

  private

  def find_selectors(component_class, node)
    selectors = node.classes || []

    child_selectors = node.elements.map do |el|
      find_selectors(component_class, el)
    end

    flat_list = selectors.concat(child_selectors).flatten.uniq
    filter_selectors(component_class, flat_list, IGNORED_SELECTORS)
  end

  def unmatched_selectors_message(component_class, selectors)
    class_name = component_class.name
    selector_list = selectors.compact.sort.join("\n")

    msg = []
    msg << "PVC Component '#{class_name}' uses CSS selectors that are not found in the PVC source:"
    msg << ""
    msg << selector_list
    msg << ""
    msg << "If these CSS selectors are not provided by PVC, they may be ignored by updating 'IGNORED_SELECTORS' in #{__FILE__}"

    msg.join("\n")
  end
end
