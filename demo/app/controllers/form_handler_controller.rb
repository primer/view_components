# frozen_string_literal: true

# :nodoc:
class FormHandlerController < ApplicationController
  layout false

  def form_action
    respond_to do |format|
      format.html do
        @form_params = form_params
      end

      format.json do
        render json: { form_params: form_params }
      end
    end
  end

  private

  def form_params
    params.permit!.to_hash.tap do |all|
      all.delete("authenticity_token")
    end
  end
end
