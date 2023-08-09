# frozen_string_literal: true

Dir[File.join(__dir__, "linters", "*.rb")].sort.each { |file| require file }
Dir[File.join(__dir__, "linters", "migrations", "*.rb")].sort.each { |file| require file }