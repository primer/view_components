# frozen_string_literal: true

module Primer
  ##
  # Generic Primer exception class.
  ##
  class PrimerError < StandardError
  end

  ##
  # Raised when checking if an instance variable
  # is not defined when it should
  ##
  class InstanceVariableNotFound < PrimerError
  end
end
