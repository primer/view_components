# frozen_string_literal: true

module Primer
  module YARD
    class ComponentManifest
      COMPONENTS = {
        Primer::Beta::RelativeTime => {},
        Primer::Beta::IconButton => {},
        Primer::Beta::Button => {},
        Primer::Alpha::SegmentedControl => {},
        Primer::Alpha::Layout => {},
        Primer::Alpha::HellipButton => {},
        Primer::Alpha::Image => {},
        Primer::LocalTime => { js: true },
        Primer::Alpha::OcticonSymbols => {},
        Primer::Alpha::ImageCrop => { js: true },
        Primer::IconButton => { js: true },
        Primer::Beta::AutoComplete => { js: true },
        Primer::Beta::AutoComplete::Item => {},
        Primer::Beta::Avatar => {},
        Primer::Beta::AvatarStack => {},
        Primer::Beta::BaseButton => {},
        Primer::Alpha::Banner => { js: true },
        Primer::Beta::Blankslate => {},
        Primer::Beta::BorderBox => {},
        Primer::Beta::BorderBox::Header => {},
        Primer::Box => {},
        Primer::Beta::Breadcrumbs => {},
        Primer::ButtonComponent => { js: true },
        Primer::Beta::ButtonGroup => {},
        Primer::Alpha::ButtonMarketing => {},
        Primer::Beta::ClipboardCopy => {js: true },
        Primer::Beta::CloseButton => {},
        Primer::Beta::Counter => {},
        Primer::Beta::Details => {},
        Primer::Alpha::Dialog => {},
        Primer::Alpha::Dropdown => { js: true },
        Primer::DropdownMenuComponent => {},
        Primer::Beta::Flash => {},
        Primer::Beta::Heading => {},
        Primer::Alpha::HiddenTextExpander => {},
        Primer::Beta::Label => {},
        Primer::LayoutComponent => {},
        Primer::Beta::Link => {js: true },
        Primer::Beta::Markdown => {},
        Primer::Alpha::Menu => {},
        Primer::Navigation::TabComponent => {},
        Primer::Beta::Octicon => {},
        Primer::Beta::Popover => {},
        Primer::Beta::ProgressBar => {},
        Primer::Beta::State => {},
        Primer::Beta::Spinner => {},
        Primer::Beta::Subhead => {},
        Primer::Alpha::TabContainer => { js: true },
        Primer::Beta::Text => {},
        Primer::TimeAgoComponent => { js: true },
        Primer::Beta::TimelineItem => {},
        Primer::Tooltip => {},
        Primer::Truncate => {},
        Primer::Beta::Truncate => {},
        Primer::Alpha::UnderlineNav => {},
        Primer::Alpha::UnderlinePanels => { js: true },
        Primer::Alpha::TabNav => {},
        Primer::Alpha::TabPanels => { js: true },
        Primer::Alpha::Tooltip => { js: true },
        Primer::Alpha::ToggleSwitch => { js: true },

        # Examples can be seen in the NavList docs
        Primer::Alpha::NavList => { js: true },
        Primer::Alpha::NavList::Item => { js: true, examples: false },
        Primer::Alpha::NavList::Section => { js: true, examples: false },

        # ActionList is a base component that should not be used by itself, and thus
        # does not have examples of its own
        Primer::Alpha::ActionList => { js: true, examples: false },
        Primer::Alpha::ActionList::Divider => { examples: false },
        Primer::Alpha::ActionList::Heading => { examples: false },
        Primer::Alpha::ActionList::Item => { examples: false },

        # Forms
        Primer::Alpha::TextField => { form_component: true }
      }

      class << self
        def each(&block)
          COMPONENTS.keys.each(&block)
        end

        def components_with_docs
          @components_with_docs ||= COMPONENTS.keys
        end

        def all_components
          @all_components ||= Primer::Component.descendants - [Primer::BaseComponent]
        end

        def components_without_docs
          @components_without_docs ||= all_components - components_with_docs
        end

        def components_with_examples
          @components_with_examples ||= COMPONENTS.keys.select do |c|
            COMPONENTS[c].fetch(:examples) { true }
          end
        end

        def components_requiring_js
          @components_requiring_js ||= COMPONENTS.keys.select do |c|
            COMPONENTS[c].fetch(:js) { false }
          end
        end

        def form_components
          @form_components ||= COMPONENTS.keys.select do |c|
            COMPONENTS[c].fetch(:form_component) { false }
          end
        end
      end
    end
  end
end
