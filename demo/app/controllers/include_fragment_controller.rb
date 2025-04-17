# frozen_string_literal: true

# :nodoc:
class IncludeFragmentController < ApplicationController
  layout false

  def landing; end

  def deferred
    render "include_fragment/deferred"
  end
end
