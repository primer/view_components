# frozen_string_literal: true

require_relative "./test_helper"
Dir["app/components/**/*.rb"].each { |file| require_relative "../../#{file}" }

# Test Component Specific Selectors
# ----
# ensure all css rules that are added to a component specific css file, are
# are present in a preview. selectors that do not show up in a preview can be
# ignored by modifying the above `IGNORED_SELECTORS` constant.
#
class ComponentSpecificSelectorsTest < Minitest::Test
  include Primer::ComponentTestHelpers
  include Primer::RenderPreview

  IGNORED_SELECTORS = {
    :global => [/^\d/, ":", /\+/, /\[.*\]/, /^to/, /^from/],
    Primer::Alpha::ActionList => [
      ".ActionListWrap--inset",
      ".ActionListItem.ActionListItem--hasSubItem > .ActionListContent",
      ".ActionListItem.ActionListItem--hasSubItem>.ActionListContent",
      ".ActionListItem.ActionListItem--danger .ActionListItem-visual",
      ".ActionListContent.ActionListContent--blockDescription .ActionListItem-visual",
      ".ActionListItem-action--leading",
      ".ActionListItem-action--trailing",
      ".ActionListItem-action",
      ".ActionListItem--subItem > .ActionListContent > .ActionListItem-label",
      ".ActionListItem--subItem>.ActionListContent>.ActionListItem-label",
      ".ActionList-sectionDivider--filled"
    ],
    Primer::Alpha::AutoComplete => [
      ".autocomplete-item"
    ],
    Primer::Alpha::Banner => [
      ".Banner .Banner-close"
    ],
    Primer::Alpha::Dialog => [
      ".Overlay"
    ],
    Primer::Alpha::Layout => [
      ".Layout-divider",
      ".Layout--divided",
      ".Layout-main",
      ".Layout.Layout--flowRow-until-lg.Layout--sidebarPosition-flowRow-end .Layout-sidebar",
      ".Layout.Layout--flowRow-until-lg.Layout--sidebarPosition-flowRow-none .Layout-sidebar"
    ],
    Primer::Alpha::TabNav => [
      ".tabnav-tab.selected",
      ".tabnav-extra",
      ".tabnav-btn"
    ],
    Primer::Alpha::TextField => [
      ".FormControl-inlineValidation p",
      ".FormControl-select",
      ".FormControl-textarea",
      ".FormControl-input",
      ".FormControl-input-wrap",
      ".FormControl-select-wrap",
      ".FormControl-checkbox-wrap",
      ".FormControl-radio-wrap",
      ".FormControl-radio-group-wrap fieldset",
      ".FormControl-check-group-wrap fieldset",
      ".FormControl-toggleSwitchInput"
    ],
    Primer::Alpha::ButtonMarketing => [
      ".btn-mktg.disabled",
      ".btn-small-mktg"
    ],
    Primer::Alpha::SegmentedControl => [
      ".Button-withTooltip"
    ],
    Primer::Alpha::UnderlineNav => [
      ".UnderlineNav .Counter--primary",
      ".UnderlineNav-item.selected",
      ".UnderlineNav--right",
      ".UnderlineNav--full",
      ".UnderlineNav-container"
    ],
    Primer::Beta::BorderBox => [
      ".Box-btn-octicon",
      ".Box--spacious .Box-title",
      ".Box-row--unread",
      ".Box-row.unread",
      ".Box-row.navigation-focus",
      ".Box-row--focus-gray",
      ".Box-row--focus-blue",
      ".Box-row-link",
      ".Box-row--drag-button",
      ".Box--scrollable",
      ".Box--blue",
      ".Box--danger",
      ".Box-header--blue"
    ],
    Primer::Beta::Button => [
      "summary.Button",
      ".Button-content--alignStart",
      ".Button--small",
      ".Button--small .Button-label",
      ".Button--large",
      ".Button--large .Button-label",
      ".Button--iconOnly",
      ".Button--iconOnly.Button--small",
      ".Button--iconOnly.Button--large"
    ],
    Primer::Beta::ButtonGroup => [
      ".BtnGroup-item.btn.selected",
      ".BtnGroup-parent"
    ],
    Primer::Beta::Avatar => [
      ".avatar-link",
      ".avatar-group-item",
      ".avatar-1",
      ".avatar-2",
      ".avatar-3",
      ".avatar-4",
      ".avatar-5",
      ".avatar-6",
      ".avatar-7",
      ".avatar-8"
    ],
    Primer::Beta::AvatarStack => [
      ".AvatarStack-body .avatar img"
    ],
    Primer::Beta::Counter => [
      "Counter .octicon"
    ],
    Primer::Beta::Label => [
      ".labels",
      ".label",
      ".Label--info",
      ".Label--warning",
      ".Label--open",
      ".Label--closed"
    ],
    Primer::Beta::Link => [".Link"],
    Primer::Beta::Blankslate => [
      ".blankslate code",
      ".blankslate-large img",
      ".blankslate-large h3",
      ".blankslate-large p",
      ".blankslate-capped",
      ".blankslate-clean-background"
    ],
    Primer::Beta::Flash => [
      ".flash-messages",
      ".flash-banner",
      ".warning"
    ],
    Primer::Alpha::Dropdown => [
      ".dropdown-caret",
      ".dropdown-menu-no-overflow",
      ".dropdown-menu-no-overflow .dropdown-item",
      ".dropdown-item.btn-link",
      ".dropdown-signout"
    ],
    Primer::Beta::Popover => [
      ".Popover-message > .btn-octicon",
      ".Popover-message>.btn-octicon"
    ],
    Primer::Alpha::Menu => [
      ".menu-item.selected",
      ".menu-item .menu-warning",
      ".menu-item .avatar",
      ".menu-item.alert .Counter"
    ],
    Primer::Beta::State => [
      ".state",
      ".State--draft",
      ".State--small .octicon"
    ],
    Primer::Beta::TimelineItem => [
      ".TimelineItem-badge--success",
      ".TimelineItem-break",
      ".TimelineItem--condensed",
      ".TimelineItem--condensed .TimelineItem-badge"
    ]
  }.freeze

  # these test methods are created dynamically so we can see all failures for
  # all components and not error after the first component failure
  Primer::Component.descendants.each do |component_class|
    class_test_name = component_class.name.downcase.gsub("::", "_")
    define_method("test_all_selectors_are_previewed_for_#{class_test_name}") do
      preview_class = get_preview_class(component_class)
      next unless preview_class

      selectors = get_component_selectors(component_class, IGNORED_SELECTORS)
      previews = preview_class.instance_methods(false)

      matched_selectors = []
      previews.each do |preview|
        preview_page = render_preview(preview, preview_klass: preview_class)

        selectors.each do |selector|
          result = preview_page.css(selector)
          matched_selectors << selector unless result.empty?
        end
      end

      remaining_selectors = (selectors - matched_selectors.flatten.uniq) || []
      assert remaining_selectors.empty?, no_preview_for_selectors_message(preview_class, remaining_selectors)
    end
  end

  private

  def no_preview_for_selectors_message(preview_class, selectors)
    class_name = preview_class.name
    selector_list = selectors.join("\n")

    msg = []
    msg << "PVC Preview Class '#{class_name}' does not render a preview for these selectors:"
    msg << ""
    msg << selector_list
    msg << ""
    msg << "Selectors without a preview may be ignored by updating 'IGNORED_SELECTORS' in #{__FILE__}"

    msg.join("\n")
  end
end
