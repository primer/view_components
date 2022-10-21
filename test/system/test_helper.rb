# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"

WebMock.disable_net_connect!(allow_localhost: true)

ENV["TZ"] = "Asia/Taipei"
