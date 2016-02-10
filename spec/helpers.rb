module Helpers
  # extend with module that holds class methods
  def self.included(base)
    base.extend ClassMethods
  end

  # shuffle set of digits
  # => return integer
  def shuffle_set(num_set)
    fail ArgumentError unless num_set.is_a?(String)
    num_set.split('').shuffle.join.to_i
  end

  module ClassMethods
    # parse json file to memory
    def data_from_file(name)
      JSON.parse(read_file(name))
    end

    private

    # read data for spec examples from file
    def read_file(name)
      File.read("#{File.dirname(__FILE__)}/lib/support/#{name}.json")
    end
  end
end
