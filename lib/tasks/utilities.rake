# frozen_string_literal: true

namespace :utilities do
  task :build do
    require "yaml"
    require "json"
    require File.expand_path("./../../demo/config/environment.rb", __dir__)
    require "primer/classify/utilities"

    # Keys that are looked for to be included in the utilities.yml file
    SUPPORTED_KEYS = %i[
      anim
      d
      float
      hide
      m mt mr mb ml mx my
      p pt pr pb pl px py
      position
      wb
      v
    ].freeze

    BREAKPOINTS = [nil, "sm", "md", "lg", "xl"].freeze

    css_data =
      JSON.parse(
        File.read(
          File.join(
            __FILE__.split("lib/tasks/utilities.rake")[0], "/node_modules/@primer/css/dist/stats/utilities.json"
          )
        )
      )["selectors"]["values"]

    output = {}

    css_data.each do |selector|
      selector.sub!(/^./, "")
      # Next if selector has ancestors or sibling selectors
      next if selector.match?(/[:><~\[\.]/)
      next unless SUPPORTED_KEYS.any? { |key| selector.start_with?("#{key}-") }

      # Dupe so we still have the selector at the end of slicing it up
      classname = selector.dup
      key = ""

      # Look for a replacement key
      Primer::Classify::Utilities::REPLACEMENT_KEYS.each do |k, v|
        next unless classname.match?(Regexp.new(k))

        key = v
        classname.sub!(Regexp.new(k + "-"), "")
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

      # Change the rest from hypens to underscores
      classname.sub!(/\-/, "_")

      # convert padding/margin negative values ie n7 to -7
      classname.sub!(/^n/, "-") if classname.match?(/^n[0-9]/)

      key = key.to_sym

      classname = if classname.match?(/\A[-+]?[0-9]+\z/)
                    classname.to_i
                  else
                    classname.to_sym
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

    File.open("lib/primer/classify/utilities.yml", "w") do |f|
      f.puts YAML.dump(output)
    end
  end
end
