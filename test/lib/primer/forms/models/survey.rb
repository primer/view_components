# frozen_string_literal: true

# :nocov:
class Survey
  if Rails::VERSION::STRING < "7.0"
    include ActiveModel::Model
  else
    include ActiveModel::API
  end

  include ActiveModel::Validations

  attr_accessor :channel

  validates :channel, presence: true
end
