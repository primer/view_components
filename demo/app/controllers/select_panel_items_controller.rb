# frozen_string_literal: true

# :nodoc:
class SelectPanelItemsController < ApplicationController
  SELECT_PANEL_ITEMS = [
    { value: 1, title: "Photon torpedo", description: "Starship-mounted missile" },
    { value: 2, title: "Bat'leth", description: "The Klingon warrior's preferred means of achieving honor" },
    { value: 3, title: "Phaser", description: "The iconic handheld laser beam" },
    { value: 4, title: "Lightsaber", description: "An elegant weapon for a more civilized age", recent: true },
    { value: 5, title: "Proton pack", description: "Ghostbusting equipment" },
    { value: 6, title: "Sonic screwdriver", description: "The Time Lord's multi-purpose tool" },
    { value: 7, title: "Tricorder", description: "Handheld sensor device", recent: true },
    { value: 8, title: "TARDIS", description: "Time and relative dimension in space" }
  ]

  COOKIE_PREFIX = "select-panel-seen-uuid-"

  def index
    # delay a bit so loading spinners, etc can be seen
    sleep 2

    if params.fetch(:fail, "false") == "true"
      uuid = params[:uuid]

      # use the uuid to succeed for the first request and fail for all subsequent requests
      if !uuid || seen_uuid?(uuid)
        render status: :internal_server_error, plain: "An error occurred"
        return
      end

      mark_seen_uuid(uuid) if uuid
    end

    show_results = params.fetch(:show_results, "true") == "true"
    query = (params[:q] || "").downcase

    results = if show_results
                SELECT_PANEL_ITEMS.select do |item|
                  [item[:title], item[:description]].join(" ").downcase.include?(query)
                end
              else
                []
              end

    if allows_selection?
      results = results.map(&:dup)
      results.each do |result|
        if selected_items.any? { |item| result[:title].downcase.include?(item) }
          result.merge!(selected: true)
          break if single_select?
        end
      end
    end

    clean_up_old_uuids(uuid)

    respond_to do |format|
      format.any(:html, :html_fragment) do
        render(
          "select_panel_items/index",
          locals: { results: results },
          layout: false,
          formats: [:html, :html_fragment]
        )
      end
    end
  end

  private

  def seen_uuid?(uuid)
    cookies.has_key?(key_for(uuid))
  end

  def mark_seen_uuid(uuid)
    cookies[key_for(uuid)] = "true"
  end

  def clean_up_old_uuids(current_uuid)
    current_key = key_for(current_uuid)
    to_delete = []

    cookies.each do |k, _|
      if k.start_with?(COOKIE_PREFIX) && k != current_key
        to_delete << k
      end
    end

    to_delete.each do |k|
      cookies.delete(k)
    end
  end

  def key_for(uuid)
    "#{COOKIE_PREFIX}#{uuid}"
  end

  def selected_items
    params.fetch(:selected_items, "").downcase.split(",").map(&:strip)
  end

  def select_variant
    @select_variant ||= params.fetch(:select_variant, Primer::Alpha::SelectPanel::DEFAULT_SELECT_VARIANT).to_sym
  end

  def single_select?
    select_variant == :single
  end

  def multi_select?
    select_variant == :multiple
  end

  def allows_selection?
    Primer::Alpha::SelectPanel::SELECT_VARIANT_OPTIONS.include?(select_variant)
  end
end
