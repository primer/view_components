# frozen_string_literal: true

# Primer::SafeHrefHelper
#
# Detects unsafe URI schemes (e.g. `javascript:`) in `href` values so they can
# be neutralized before being rendered into HTML attributes. Without this check,
# a caller that forwards untrusted input into a component's `href:` argument can
# trigger XSS when the user clicks the rendered anchor.
module Primer
  # :nodoc:
  module SafeHrefHelper
    # URI schemes that can execute script in the browser and are never valid
    # destinations for a Primer-rendered link.
    DISALLOWED_HREF_SCHEMES = %w[javascript vbscript].freeze

    # Returns true when `href` starts with a disallowed URI scheme.
    #
    # Mirrors browser URL parsing by stripping ASCII whitespace and control
    # characters (including tab/CR/LF) before extracting the scheme. This
    # prevents bypasses such as `j\tavascript:...`, ` JaVaScRiPt:...`, or a
    # leading null byte, all of which browsers happily execute.
    def self.unsafe_href?(href)
      return false if href.nil?

      normalized = href.to_s.gsub(/[\u0000-\u0020]/, "")
      scheme = normalized[/\A([a-z][a-z0-9+\-.]*):/i, 1]
      return false unless scheme

      DISALLOWED_HREF_SCHEMES.include?(scheme.downcase)
    end

    def unsafe_href?(href)
      SafeHrefHelper.unsafe_href?(href)
    end
  end
end
