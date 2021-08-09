# frozen_string_literal: true

Dir[File.join(__dir__, "primer", "*.rb")].sort.each { |file| require file }
