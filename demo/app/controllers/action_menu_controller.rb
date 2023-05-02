# frozen_string_literal: true

# :nodoc:
class ActionMenuController < ApplicationController
  layout false

  def landing; end

  def deferred
    render "action_menu/deferred"
  end

  def deferred_preload
    render "action_menu/deferred_preload"
  end

  def form_action
    respond_to do |format|
      format.html do
        @value = form_action_selected_value
      end

      format.json do
        render json: { value: form_action_selected_value }
      end
    end
  end

  private

  def form_action_selected_value
    params.permit(:foo)[:foo] || params.permit(foo: [])[:foo]
  end
end
