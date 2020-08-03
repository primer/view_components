module Primer
  module ViewComponents
    class Engine < ::Rails::Engine
      isolate_namespace Primer::ViewComponents
    end
  end
end

require "#{Primer::ViewComponents::Engine.root.to_s}/app/components/primer/view_components.rb"
