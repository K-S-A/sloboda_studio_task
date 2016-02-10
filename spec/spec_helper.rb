require 'bundler/setup'
Bundler.require

require 'shared_stuff'
require 'helpers'

Dir["#{File.expand_path('..', File.dirname(__FILE__))}/lib/*.rb"].each do |file|
  require file
end

RSpec.configure do |config|
  # extend with helper methods
  config.include Helpers

  config.order = :random

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end
end
