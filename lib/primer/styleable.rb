# frozen_string_literal: true

module Primer
  module Styleable
    MARGIN_DIRECTION_KEYS = [:mt, :ml, :mb, :mr]
    SPACING_KEYS = ([:m, :my, :mx, :p, :py, :px, :pt, :pl, :pb, :pr]).freeze

    VALID_POSITIONS = {
      relative: "position-relative",
      absolute: "position-absolute",
      fixed: "position-fixed"
    }

    def primer_class_list
      @_primer_class_list ||= []
    end

    def primer_classes
      primer_class_list.join(" ")
    end

    # Generate margin methods
    # These are separate from the SPACING_KEYS since margins with directions accept negative values
    MARGIN_DIRECTION_KEYS.each do |margin_direction|
      define_method margin_direction do |val|
        raise ArgumentError, "value must be between -6 and 6" if (val < -6 || val > 6)

        if val < 0
          primer_class_list << "#{margin_direction}-n#{val.abs}"
        else
          primer_class_list << "#{margin_direction}-#{val}"
        end

        self
      end
    end

    # Generate spacing methods
    SPACING_KEYS.each do |spacing|
      define_method spacing do |val|
        raise ArgumentError, "value must be between 0 and 6" if (val < 0 || val > 6)

        primer_class_list << "#{spacing}-#{val}"

        self
      end
    end

    def f(size)
      primer_class_list << "f#{size}"
      self
    end

    def position(value)
      raise ArgumentError, "must be one of #{VALID_POSITIONS.keys.join(", ")}" unless value.in?(VALID_POSITIONS.keys)

      primer_class_list << VALID_POSITIONS[value.to_sym]
      self
    end

    def float(direction)
      primer_class_list << "float-#{direction}"
      self
    end

    def underline
      primer_class_list << "text-underline"
      self
    end

    def no_underline
      primer_class_list << "no-underline"
      self
    end

    # direction-0 mappings
    [:top, :left, :bottom, :right].each do |direction|
      define_method "#{direction}0" do
        primer_class_list << "#{direction}-0"
        self
      end
    end

    [:block, :none, :inline, :inline_block, :table, :table_cell].each do |display_value|
      define_method display_value do
        primer_class_list << "d-#{display_value.to_s.dasherize}"
        self
      end
    end

    [:hidden, :visible].each do |visible_value|
      define_method visible_value do
        primer_class_list << "v-#{visible_value}"
        self
      end
    end

    [:sm, :md, :lg, :xl].each do  |size|
      define_method "hide_#{size}" do
        primer_class_list << "hide-#{size}"
        self
      end
    end

    [:baseline, :top, :middle, :bottom, :text_top, :text_bottom].each do  |alignment|
      define_method "valign_#{alignment}" do
        primer_class_list << "v-align-#{alignment.to_s.dasherize}"
        self
      end
    end
  end
end
