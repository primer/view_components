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
        @other_params = form_action_other_params
      end

      format.json do
        render json: { value: form_action_selected_value, other_params: form_action_other_params }
      end
    end
  end

  private

  def form_action_selected_value
    params.permit(:foo)[:foo] || params.permit(foo: [])[:foo]
  end

  def form_action_other_params
    params.permit!.to_hash.tap do |all|
      case all
      when Hash
        all.delete("foo")
        all.delete("authenticity_token")
      when Array
        all.delete(form_action_selected_value)
      end
    end
  end
end
