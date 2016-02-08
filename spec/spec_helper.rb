require 'bundler/setup'

Bundler.require

RSpec.configure do |config|

  config.order = :random

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

end
