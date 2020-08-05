# frozen_string_literal: true

require "active_support/core_ext"

# ViewComponent

require "view_component/engine"

# Helpers

require "primer/class_name_helper"
require "primer/classify"
require "primer/fetch_or_fallback_helper"

# Base configurations

require_relative "./component"
require_relative "./base_component"

# Components

require_relative "./border_box_component"
require_relative "./box_component"
require_relative "./button_component"
require_relative "./counter_component"
require_relative "./flex_component"
require_relative "./flex_item_component"
require_relative "./heading_component"
require_relative "./label_component"
require_relative "./layout_component"
require_relative "./link_component"
require_relative "./progress_bar_component"
require_relative "./state_component"
require_relative "./text_component"
