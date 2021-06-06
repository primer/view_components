# frozen_string_literal: true

namespace :utilities do
  task :build do
    require "yaml"
    require "json"
    require File.expand_path("./../../demo/config/environment.rb", __dir__)
    require "primer/view_components"

    SUPPORTED_KEYS = %i[hide float m mt mr mb ml mx my p pt pr pb pl px py].freeze

    KEYS = {
      "^v-align" => "vertical_align",
      "^d" => "display",
      "^wb" => "word_break",
      "^v" => "visibility"
    }.freeze

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

      classname = selector.dup

      key = classname.split("-").first

      KEYS.each do |k, v|
        next unless classname.match?(Regexp.new(k))

        key = v
        classname.sub!(Regexp.new(k + "-"), "")
      end

      if classname == selector
        dash_index = classname.index("-") || 0
        key = classname[0..dash_index - 1]
        classname.sub!(/^[^-]+-/, "")
      end

      if classname.match?(/^(sm-|md-|lg-|xl-)/)
        breakpoint = classname[0..classname.index("-") - 1]
        classname.sub!(/^[^-]+-/, "")
      end

      classname.sub!(/\-/, "_")
      # convert n7 to -7
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

    File.open("app/lib/primer/classify/utilities.yml", "w") do |f|
      f.puts YAML.dump(output)
    end
  end
end
