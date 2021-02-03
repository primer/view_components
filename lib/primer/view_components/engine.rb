# frozen_string_literal: true

module Primer
  module ViewComponents
    # :nodoc
    class Engine < ::Rails::Engine
      isolate_namespace Primer::ViewComponents
    end
  end
end

require "#{Primer::ViewComponents::Engine.root}/app/components/primer/view_components.rb"
