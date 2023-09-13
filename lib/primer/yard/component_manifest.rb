# frozen_string_literal: true

# :nocov:
module Primer
  module Yard
    # The set of documented components (and associated metadata).
    class ComponentManifest
      COMPONENTS = {
        Primer::Beta::RelativeTime => {},
        Primer::Beta::IconButton => {},
        Primer::Beta::Button => {},
        Primer::Alpha::SegmentedControl => {},
        Primer::Alpha::Layout => {},
        Primer::Alpha::HellipButton => {},
        Primer::Alpha::Image => {},
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
        Primer::BlankslateComponent => {},
        Primer::Beta::BorderBox => {},
        Primer::Beta::BorderBox::Header => {},
        Primer::Box => {},
        Primer::Beta::Breadcrumbs => {},
        Primer::ButtonComponent => { js: true },
        Primer::Beta::ButtonGroup => {},
        Primer::Alpha::ButtonMarketing => {},
        Primer::Beta::ClipboardCopy => { js: true },
        Primer::Beta::CloseButton => {},
        Primer::Beta::Counter => {},
        Primer::Beta::Details => {},
        Primer::Alpha::Dialog => {},
        Primer::Alpha::Dropdown => { js: true },
        Primer::Beta::Flash => {},
        Primer::Beta::Heading => {},
        Primer::Alpha::HiddenTextExpander => {},
        Primer::Beta::Label => {},
        Primer::LayoutComponent => {},
        Primer::Beta::Link => { js: true },
        Primer::Beta::Markdown => {},
        Primer::Alpha::Menu => {},
        Primer::Navigation::TabComponent => {},
        Primer::Alpha::Navigation::Tab => {},
        Primer::Beta::Octicon => {},
        Primer::Beta::Popover => {},
        Primer::Beta::ProgressBar => {},
        Primer::Beta::State => {},
        Primer::Beta::Spinner => {},
        Primer::Beta::Subhead => {},
        Primer::Alpha::TabContainer => { js: true },
        Primer::Beta::Text => {},
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
        Primer::Alpha::Overlay => { js: true },
        Primer::Alpha::ActionMenu => { js: true },

        # Examples can be seen in the NavList docs
        Primer::Beta::NavList => { js: true },
        Primer::Beta::NavList::Item => { js: true, examples: false },
        Primer::Beta::NavList::Group => { js: true, examples: false },

        # ActionList is a base component that should not be used by itself, and thus
        # does not have examples of its own
        Primer::Alpha::ActionList => { js: true, examples: false },
        Primer::Alpha::ActionList::Divider => { examples: false },
        Primer::Alpha::ActionList::Heading => { examples: false },
        Primer::Alpha::ActionList::Item => { examples: false },

        # Forms
        Primer::Alpha::TextField => { form_component: true },
        Primer::Alpha::TextArea => { form_component: true, published: false },
        Primer::Alpha::Select => { form_component: true, published: false },
        Primer::Alpha::MultiInput => { form_component: true, js: true, published: false },
        Primer::Alpha::RadioButton => { form_component: true, published: false },
        Primer::Alpha::RadioButtonGroup => { form_component: true, published: false },
        Primer::Alpha::CheckBox => { form_component: true, published: false },
        Primer::Alpha::CheckBoxGroup => { form_component: true, published: false },
        Primer::Alpha::SubmitButton => { form_component: true, published: false },
        Primer::Alpha::FormButton => { form_component: true, published: false }
      }.freeze

      include Enumerable

      def initialize(components)
        @components = components
      end

      def each
        return to_enum(__method__) unless block_given?

        @components.each do |klass|
          yield self.class.ref_for(klass)
        end
      end

      def where(**attrs)
        self.class.where(@components, **attrs)
      end

      class << self
        def where(components = COMPONENTS, **desired_attrs)
          new(
            components.each_with_object([]) do |(klass, component_attrs), memo|
              matches = desired_attrs.all? do |name, desired_value|
                component_attrs.fetch(name, ComponentRef::ATTR_DEFAULTS[name]) == desired_value
              end

              memo << klass if matches
            end
          )
        end

        def all
          new(COMPONENTS.keys)
        end

        def ref_for(klass)
          ref_cache[klass] ||= ComponentRef.new(klass, COMPONENTS.fetch(klass, {}))
        end

        private

        def ref_cache
          @ref_cache ||= {}
        end
      end
    end
  end
end
# :nocov:
