# frozen_string_literal: true

require "rails/application_controller"

class PreviewController < ViewComponentsController # :nodoc:
  helper Lookbook::PreviewHelper if defined?(Lookbook)
  helper Primer::ViewHelper
end