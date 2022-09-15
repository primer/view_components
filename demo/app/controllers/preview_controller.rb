# frozen_string_literal: true

require "rails/application_controller"

class PreviewController < ViewComponentsController # :nodoc:
  unless Rails.version.to_i < 7
    helper Lookbook::PreviewHelper
  end
  helper Primer::ViewHelper
end
