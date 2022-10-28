# frozen_string_literal: true

require "components/test_helper"

class PrimerBetaCounterTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_hidden_by_css_if_count_is_nil
    render_inline(Primer::Beta::Counter.new(count: nil))

    assert_selector(".Counter")
    assert_selector("[title='Not available']")
  end

  def test_shows_when_count_is_0
    render_inline(Primer::Beta::Counter.new(count: 0))

    assert_selector("[title='0']", text: "0")
  end

  def test_renders_when_count_is_5
    render_inline(Primer::Beta::Counter.new(count: 5))

    assert_selector("[title='5']", text: "5")
  end

  def test_hide_if_count_is_0_and_if_hide_if_zero_is_true
    render_inline(Primer::Beta::Counter.new(count: 0, hide_if_zero: true))

    assert_selector("[hidden='hidden']", text: "0", visible: false)
  end

  def test_renders_count_limit
    render_inline(Primer::Beta::Counter.new(count: 1000, limit: 100))

    assert_selector("[title='100+']", text: "100+")
  end

  def test_scheme_falls_back_to_default
    without_fetch_or_fallback_raises do
      render_inline(Primer::Beta::Counter.new(scheme: :pink, count: 2))

      assert_selector(".Counter[title='2']")
    end
  end

  def test_render_small_number
    render_inline(Primer::Beta::Counter.new(count: 123))

    assert_selector("[title='123']", text: "123")
  end

  def test_render_999
    render_inline(Primer::Beta::Counter.new(count: 999))

    assert_selector("[title='999']", text: "999")
  end

  def test_simplify_the_number_using_the_former_social_count_logic_if_round_true
    render_inline(Primer::Beta::Counter.new(count: 1_234, round: true))

    assert_selector("[title='1,234']", text: "1.2k")
  end

  def test_simplify_the_number_using_the_former_social_count_logic_with_limit
    render_inline(Primer::Beta::Counter.new(count: 5_001, round: true))

    assert_selector("[title='5,000+']", text: "5k+")
  end

  def test_render_when_over_limit
    render_inline(Primer::Beta::Counter.new(count: 5_001))

    assert_selector("[title='5,000+']", text: "5,000+")
  end

  def test_rounds_hundreds_of_thousands
    render_inline(Primer::Beta::Counter.new(count: 123_456, limit: 1_000_000_000, round: true))

    assert_selector("[title='123,456']", text: "123k")
  end

  def test_rounds_millions
    render_inline(Primer::Beta::Counter.new(count: 1_234_567, limit: 1_000_000_000, round: true))

    assert_selector("[title='1,234,567']", text: "1.2m")
  end

  def test_rounds_billions
    render_inline(Primer::Beta::Counter.new(count: 1_234_567_890, limit: 10_000_000_000, round: true))

    assert_selector("[title='1,234,567,890']", text: "1.2b")
  end

  def test_no_limit
    render_inline(Primer::Beta::Counter.new(count: 5_001, limit: nil))

    assert_selector("[title='5,001']", text: "5,001")
  end

  def test_rounds_no_limit
    render_inline(Primer::Beta::Counter.new(count: 1_234_567_890, limit: nil, round: true))

    assert_selector("[title='1,234,567,890']", text: "1.2b")
  end

  def test_renders_with_the_css_class_scheme_mapping_to_the_provided_scheme
    render_inline(Primer::Beta::Counter.new(count: 20, scheme: :primary))

    assert_selector(".Counter.Counter--primary")
    assert_selector("[title='20']", text: "20")
  end

  def test_renders_with_the_css_class_scheme_mapping_to_the_provided_deprecated_scheme
    render_inline(Primer::Beta::Counter.new(count: 20, scheme: :gray))

    assert_selector(".Counter.Counter--primary")
    assert_selector("[title='20']", text: "20")
  end

  def test_render_active_support_safe_buffer_as_count
    render_inline(Primer::Beta::Counter.new(count: ActiveSupport::SafeBuffer.new("20"), limit: 10))

    assert_selector("[title='10+']", text: "10+")
  end

  def test_render_infinity
    render_inline(Primer::Beta::Counter.new(count: Float::INFINITY))

    assert_selector("[title='Infinity']", text: "∞")
  end

  def test_render_arbitrary_string
    render_inline(Primer::Beta::Counter.new(text: "?"))

    assert_selector("[title='?']", text: "?")
  end

  def test_status
    assert_component_state(Primer::Beta::Counter, :beta)
  end
end
