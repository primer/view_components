# frozen_string_literal: true

class PreviewController < ViewComponentsController
  helper Lookbook::PreviewHelper if defined?(Lookbook)
  helper Primer::ViewHelper
end