# frozen_string_literal: true

require "components/test_helper"
require "json"

class PrimerBetaRelativeTimeTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_component_matches_web_component_definition
    assert_custom_element_manifest "@github/relative-time-element", Primer::Beta::RelativeTime
  end

  def test_component_accepts_string_date_format
    render_inline(Primer::Beta::RelativeTime.new(datetime: "2022-12-06T11:14:46Z"))
    assert_selector("relative-time", text: "December 6, 2022 11:14")
  end

  def test_component_accepts_time_date_format
    datetime = Time.utc(2022, 12, 6, 11, 14, 46)
    render_inline(Primer::Beta::RelativeTime.new(datetime: datetime))
    assert_selector("relative-time", text: "December 6, 2022 11:14")
    assert_no_selector("relative-time[absolute-format]")
  end

  def test_component_accepts_hour_cycle
    render_inline(Primer::Beta::RelativeTime.new(datetime: "2022-12-06T11:14:46Z", hour_cycle: :h23))
    assert_selector("relative-time[hour-cycle='h23']")
  end

  def test_compact_absolute_format_keeps_fallback_and_custom_title
    datetime = Time.utc(2022, 12, 6, 11, 14, 46)
    render_inline(Primer::Beta::RelativeTime.new(datetime: datetime, absolute_format: :compact, title: "Complete timestamp"))

    assert_selector("relative-time[absolute-format='compact'][datetime='#{datetime.iso8601}'][title='Complete timestamp']", exact_text: "December 6, 2022 11:14")
  end

  def test_compact_absolute_format_keeps_no_title
    render_inline(Primer::Beta::RelativeTime.new(datetime: "2022-12-06T11:14:46Z", absolute_format: :compact, no_title: true))

    assert_selector("relative-time[absolute-format='compact'][no-title]")
    assert_no_selector("relative-time[title]")
  end

  def test_invalid_absolute_format_raises
    assert_raises(Primer::FetchOrFallbackHelper::InvalidValueError) do
      render_inline(Primer::Beta::RelativeTime.new(datetime: "2022-12-06T11:14:46Z", absolute_format: :invalid))
    end
  end

  def test_invalid_absolute_format_falls_back_to_no_attribute
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::RelativeTime.new(datetime: "2022-12-06T11:14:46Z", absolute_format: :invalid))

      assert_selector("relative-time:not([absolute-format])", exact_text: "December 6, 2022 11:14")
    end
  end

  private

  def assert_custom_element_manifest(package_name, class_obj)
    package_json = JSON.parse(File.read("./node_modules/#{package_name}/package.json"))
    manifest_file = package_json.fetch("customElements")
    contents = File.read("./node_modules/#{package_name}/#{manifest_file}")
    json = JSON.parse(contents)
    class_name = "#{class_obj.name.split('::').last}Element"
    decls = json.fetch("modules").flat_map do |mod|
      mod.fetch("declarations").select { |decl| decl.fetch("kind") == "class" }
    end
    class_decl = decls.find { |decl| decl.fetch("name") == class_name }
    class_params = class_obj.instance_method(:initialize).parameters.select { |param| param.first == :keyreq || param.first == :key }.map(&:last)
    fields = class_decl.fetch("attributes").filter_map { |attr| attr.fetch("name").underscore.to_sym }
    deprecated_fields = class_decl.fetch("members").filter_map do |member|
      member.fetch("name").to_sym if member.key?("deprecated")
    end
    deprecated_fields.each do |field|
      puts "WARNING: field #{field} deprecated on #{class_name}" if class_params.include?(field)
    end

    assert_empty fields - class_params, "Missing params on component"
    assert_empty class_params - fields - deprecated_fields, "Extra fields on component"
  end
end
