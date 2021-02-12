# frozen_string_literal: true

require "active_support/core_ext"

# ViewComponent

require "view_component/engine"

# Octicons

require "octicons_helper/helper"

# Helpers

require "primer/class_name_helper"
require "primer/classify"
require "primer/fetch_or_fallback_helper"
require "primer/join_style_arguments_helper"

# Base configurations

require_relative "component"
require_relative "base_component"
require_relative "slot"

# Components

require_relative "avatar_component"
require_relative "avatar_stack_component"
require_relative "blankslate_component"
require_relative "border_box_component"
require_relative "box_component"
require_relative "breadcrumb_component"
require_relative "button_component"
require_relative "button_group_component"
require_relative "button_marketing_component"
require_relative "counter_component"
require_relative "details_component"
require_relative "dropdown_component"
require_relative "dropdown_menu_component"
require_relative "flash_component"
require_relative "flex_component"
require_relative "flex_item_component"
require_relative "heading_component"
require_relative "label_component"
require_relative "layout_component"
require_relative "link_component"
require_relative "menu_component"
require_relative "octicon_component"
require_relative "popover_component"
require_relative "progress_bar_component"
require_relative "spinner_component"
require_relative "state_component"
require_relative "subhead_component"
require_relative "text_component"
require_relative "timeline_item_component"
require_relative "tooltip_component"
require_relative "truncate_component"
require_relative "underline_nav_component"
