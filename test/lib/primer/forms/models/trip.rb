# frozen_string_literal: true

# :nocov:
class Trip
  if Rails::VERSION::STRING < "7.0"
    include ActiveModel::Model
  else
    include ActiveModel::API
  end

  include ActiveModel::Validations

  attr_accessor :places

  validates :places, length: { minimum: 2, too_short: "must have at least two selections" }

  def initialize(**params)
    super

    @places ||= []
  end
end
