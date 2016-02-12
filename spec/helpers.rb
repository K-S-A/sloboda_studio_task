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

  # return Hash for initialization of Cities instance
  def cities_hash
    {
      1 => { name: 'gdansk', conns: { 2 => 1, 3 => 3 } },
      2 => { name: 'bydgoszcz', conns: { 1 => 1, 3 => 1, 4 => 4 } },
      3 => { name: 'torun', conns: { 1 => 3, 2 => 1, 4 => 1 } },
      4 => { name: 'warszawa', conns: { 2 => 4, 3 => 1 } }
    }
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

    # => String
    # return name of sample data file location
    def cities_data_file
      'spec/lib/support/cities_data.txt'
    end

    # => Hash
    # hash where:
    # key - arguments for #cheapest_cost and #cheapest_path;
    # value - array of expected results for [ #cheapest_cost, #cheapest_path ]
    def test_hash(index = 0)
      {
        %w(gdansk warszawa) => [3, %w(gdansk bydgoszcz torun warszawa)],
        %w(bydgoszcz warszawa) => [2, %w(bydgoszcz torun warszawa)]
      }.map { |k, v| [k, v[index]] }
    end
  end
end
