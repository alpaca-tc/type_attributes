$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'type_attributes'

RSpec.configure do |config|
  config.order = :random
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end
end
