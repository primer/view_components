# frozen_string_literal: true

# :nodoc:
class ActionMenuController < ApplicationController
  layout false

  def landing
  end

  def deferred
    render "action_menu/deferred"
  end

  def deferred_preload
    render "action_menu/deferred_preload"
  end
end
