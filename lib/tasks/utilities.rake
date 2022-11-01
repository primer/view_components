# frozen_string_literal: true

namespace :utilities do
  task :build do
    require "yaml"
    require "json"
    ENV["RAILS_ENV"] = "test"
    require File.expand_path("./../../demo/config/environment.rb", __dir__)
    require "primer/classify/utilities"

    # Keys that are looked for to be included in the utilities.yml file
    # rubocop:disable Lint/ConstantDefinitionInBlock
    SUPPORTED_KEYS = [
      /^anim\b/,
      /^color-bg\b/,
      /^color-border\b/,
      /^color-fg\b/,
      /^col\b/,
      /^container\b/,
      /^clearfix\b/,
      /^d\b/,
      /^float\b/,
      /^height\b/,
      /^hide\b/,
      /^m[trblxy]?\b/,
      /^p[trblxy]?\b/,
      /^position\b/,
      /^wb\b/,
      /^width\b/,
      /^v\b/
    ].freeze

    BREAKPOINTS = [nil, "sm", "md", "lg", "xl"].freeze
    # rubocop:enable Lint/ConstantDefinitionInBlock

    utility_data = JSON.parse(File.read("app/lib/primer/css/utilities.css.json"))["selectors"]
    layout_data = JSON.parse(File.read("app/lib/primer/css/layout.css.json"))["selectors"]
    css_data = utility_data + layout_data

    output = {}

    css_data.each do |selector|
      selector.sub!(/^./, "")
      selector.sub!(/:[^\s]*$/, "")

      # Next if selector has ancestors or sibling selectors
      next if selector.match?(/[:><~\[.]/)
      next unless SUPPORTED_KEYS.any? { |key| selector =~ key }

      # Dupe so we still have the selector at the end of slicing it up
      classname = selector.dup
      key = ""

      # Look for a replacement key
      Primer::Classify::Utilities::REPLACEMENT_KEYS.each do |k, v|
        next unless classname.match?(Regexp.new(k))

        key = v
        classname.sub!(Regexp.new("#{k}-"), "")
      end

      # If we didn't find a replacement, grab the first text before hyphen
      if classname == selector
        key = classname.split("-").first
        classname.sub!(/^[^-]+-/, "")
      end

      # Check if the next bit of the classname is a breakpoint
      if classname.match?(/^(sm-|md-|lg-|xl-)/)
        breakpoint = classname.split("-").first
        classname.sub!(/^[^-]+-/, "")
      end

      # Change the rest from hyphens to underscores
      classname.sub!(/-/, "_")

      # convert padding/margin negative values ie n7 to -7
      classname.sub!(/^n/, "-") if classname.match?(/^n[0-9]/)

      # If key and classname are equal, then classname is boolean
      classname = true if key == classname

      key = key.to_sym

      if classname.is_a?(String)
        classname = classname.match?(/\A[-+]?[0-9]+\z/) ? classname.to_i : classname.to_sym
      end

      if output[key].nil?
        output[key] = { classname => Array.new(5, nil) }
      elsif output[key][classname].nil?
        output[key][classname] = Array.new(5, nil)
      end

      output[key][classname][BREAKPOINTS.index(breakpoint)] = selector
    end

    output.transform_values! do |x|
      x.transform_values { |y| y.reverse.drop_while(&:nil?).reverse }
    end

    custom_utility_data = YAML.load_file("lib/tasks/custom_utilities.yml")
    output.merge!(custom_utility_data)

    File.open("lib/primer/classify/utilities.yml", "w") do |f|
      f.puts YAML.dump(output)
    end
  end
end
