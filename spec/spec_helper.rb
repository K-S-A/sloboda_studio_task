require 'bundler/setup'
Bundler.require

require_relative 'shared_examples'

Dir["#{File.expand_path('..', File.dirname(__FILE__))}/lib/*.rb"].each do |file|
  require file
end

RSpec.configure do |config|

  config.order = :random

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

end
