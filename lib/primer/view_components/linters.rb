# frozen_string_literal: true

Dir[
  File.join(__dir__, "linters", "*.rb"),
  File.join(__dir__, "linters", "primer", "*.rb")
].sort.each { |file| require file }
