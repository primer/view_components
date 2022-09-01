# frozen_string_literal: true

require "rails/application_controller"

class PreviewController < ViewComponentsController # :nodoc:
  helper Lookbook::PreviewHelper
  helper Primer::ViewHelper
end
