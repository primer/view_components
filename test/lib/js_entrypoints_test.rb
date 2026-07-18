# frozen_string_literal: true

require "test_helper"

# Ensures that the eager entry (primer.ts) and the lazy entry (lazy.ts) contain
# the same set of element modules so they never drift out of sync.
class JsEntrypointsTest < Minitest::Test
  PRIMER_TS = File.join(__dir__, "../../app/components/primer/primer.ts")
  LAZY_TS = File.join(__dir__, "../../app/components/primer/lazy.ts")

  # Modules imported eagerly in lazy.ts (side-effects, no custom-element tag)
  EAGER_IMPORTS_IN_LAZY = %w[
    ./shared_events
    ./utils
    @github/include-fragment-element
    @github/remote-input-element
  ].freeze

  def test_primer_ts_and_lazy_ts_have_same_element_modules
    primer_modules = parse_primer_ts_imports
    lazy_modules = parse_lazy_ts_import_paths

    missing_from_lazy = primer_modules - lazy_modules
    extra_in_lazy = lazy_modules - primer_modules

    assert missing_from_lazy.empty?,
      "These modules are imported in primer.ts but missing from lazy.ts:\n" \
      "  #{missing_from_lazy.join("\n  ")}\n\n" \
      "Add them to the lazyDefine({}) call in app/components/primer/lazy.ts"

    assert extra_in_lazy.empty?,
      "These modules appear in lazy.ts but not in primer.ts:\n" \
      "  #{extra_in_lazy.join("\n  ")}\n\n" \
      "Add them to app/components/primer/primer.ts or remove from lazy.ts"
  end

  private

  # Extract all import paths from primer.ts, then remove the ones that are
  # eagerly imported in lazy.ts (side-effect modules and external base deps).
  def parse_primer_ts_imports
    content = File.read(PRIMER_TS)
    paths = content.scan(/^import '(.+)'$/).flatten

    # Remove external packages that are imported eagerly in lazy.ts
    paths.reject { |path| EAGER_IMPORTS_IN_LAZY.include?(path) }
  end

  # Extract all dynamic import() paths from the lazyDefine call in lazy.ts.
  def parse_lazy_ts_import_paths
    content = File.read(LAZY_TS)
    content.scan(/\(\) => import\('([^']+)'\)/).flatten
  end
end
