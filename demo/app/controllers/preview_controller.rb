# frozen_string_literal: true

require "rails/application_controller"

class PreviewController < ViewComponentsController # :nodoc:
  helper Lookbook::PreviewHelper if Rails.version.to_i >= 7
  helper Primer::ViewHelper
end
