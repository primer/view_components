# frozen_string_literal: true

module Primer
  module ClipboardTestHelpers

    module MethodOverrides
      def setup
        @clipboard_stubbed = false
        super
      end
    end

    def self.included(base)
      base.prepend(MethodOverrides)
    end

    def clipboard_stubbed?
      @clipboard_stubbed
    end

    def stub_clipboard!
      page.evaluate_script(<<~JS)
        (() => {
          navigator.clipboard.writeText = async (text) => {
            this.text = text;
            return Promise.resolve(null);
          };

          navigator.clipboard.readText = async () => {
            return Promise.resolve(this.text);
          };
        })()
      JS

      @clipboard_stubbed = true
    end

    def read_clipboard
      page.evaluate_async_script(<<~JS)
        const [done] = arguments;
        navigator.clipboard.readText().then(done).catch((e) => done(e));
      JS
    end

    def capture_clipboard
      stub_clipboard! unless clipboard_stubbed?
      yield
      read_clipboard
    end
  end
end
