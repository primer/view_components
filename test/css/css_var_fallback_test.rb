# frozen_string_literal: true

require "components/test_helper"

class Primer::CssVariableTest < Minitest::Test
  class CssFile
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def contents
      @contents ||= File.read(path)
    end

    def find_offset(pos)
      line_idx = line_ranges.bsearch_index do |range|
        if pos < range.first
          -1
        elsif pos > range.last
          1
        else
          0
        end
      end

      return unless line_idx

      line_range = line_ranges[line_idx]
      [line_idx + 1, pos - line_range.first]
    end

    private

    def line_ranges
      @line_ranges ||= [].tap do |ranges|
        idx = 0

        loop do
          next_idx = contents.index("\n", idx)
          break unless next_idx

          ranges << (idx..next_idx)
          idx = next_idx + 1
        end
      end
    end
  end

  def test_css_rules_all_contain_fallbacks
    # 1. Find compiled CSS file
    css_file = CssFile.new(
      Rails.root.join(*%w[.. app assets styles primer_view_components.css]).to_s
    )

    # 2. Load file and run regex on it which checks for any CSS var containing new color terms
    regex = /var\(--(shadow|borderColor|bgColor|fgColor|iconColor)[^),]*\)\s*(,|;|\s)/

    missing = [].tap do |missing|
      css_file.contents.scan(regex) do |match|
        start_pos, = Regexp.last_match.offset(0)
        line, col = css_file.find_offset(start_pos)
        source_file = Pathname(css_file.path).relative_path_from(Rails.root.join(".."))
        missing << "#{source_file}:#{line}:#{col}"
      end
    end

    missing.uniq!

    # 3. Use assert method (and friends) to verify it works
    assert_equal 0, missing.length, "The CSS variables in the following files are missing fallbacks:\n  #{missing.join("\n  ")}"
  end
end
