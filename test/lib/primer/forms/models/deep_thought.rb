# frozen_string_literal: true

class DeepThought
  if Rails::VERSION::STRING < "7.0"
    include ActiveModel::Model
  else
    include ActiveModel::API
  end

  include ActiveModel::Validations

  attr_reader :ultimate_answer

  def initialize(ultimate_answer)
    @ultimate_answer = ultimate_answer
  end

  validates :ultimate_answer, numericality: { greater_than: 41, less_than: 43 }
end
