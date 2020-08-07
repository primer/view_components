require "primer/view_components"

if Rails.env.development?
  Primer::ViewComponents.configure do |config|
    config.autoload = true
  end

  require "primer/view_components/engine"
end
