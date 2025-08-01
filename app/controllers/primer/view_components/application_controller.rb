# frozen_string_literal: true

module Primer
  module ViewComponents
    # :nodoc:
    class ApplicationController < ActionController::Base
      protect_from_forgery with: :exception
    end
  end
end
