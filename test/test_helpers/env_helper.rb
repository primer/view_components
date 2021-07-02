# frozen_string_literal: true

module Primer
  module EnvHelper
    def with_env(env)
      old_env = ENV["RAILS_ENV"]
      ENV["RAILS_ENV"] = env

      Rails.stub(:env, ActiveSupport::StringInquirer.new(env)) do
        yield
      end
    ensure
      ENV["RAILS_ENV"] = old_env
    end
  end
end
