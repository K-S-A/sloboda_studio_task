###############################################################################
# Models map of connected stations.
# #cheapest_cost(origin, destination) => return cheapest transfer cost (Integer)
# #cheapest_path(origin, destination) =>
#   return list of stations names for cheapest path (Array)
# must be initialized with Hash
# when initialized with string - get hash of data from supplied path
# Hash structure:{ <station_number>:
#                  { name: '<station_name>',
#                    conns: { <number_of_next_station>: <transfer_cost>, ...
#                    }
#                  }
#                }
# Assumed that cost between cities is the SAME for both directions.
###############################################################################
class Cities
  attr_reader :map

  def initialize(data)
    @map = case data
           when String then read_from_file(data)
           when Hash   then data
           else fail ArgumentError
           end
  end

  # => Integer, cheapest cost between stations
  def cheapest_cost(origin, destination)
    totals = []
    path(origin, destination) { |_, c| totals << c }
    totals.min
  end

  # => Array, list of stations names for cheapest cost travel
  def cheapest_path(origin, destination)
    results = []
    path(origin, destination) { |*l| results << l }
    verbose_path(results.min_by(&:last)[0])
  end

  private

  # => Hash
  # Read file line by line; add parsed line to hash if line matches patterns
  # for station name or connection graph
  def read_from_file(name)
    File.foreach(name).with_object({}) do |line, hsh|
      case line
      # case for connection
      when /^\d+ \d+\n$/
        direction, cost = line.split.map(&:to_i)
        hsh[hsh.size][:conns][direction] = cost
      # case for station name
      when /^\p{L}+\n$/
        hsh[hsh.size + 1] = { name: line.chomp, conns: {} }
      end
    end
  end

  # recursively yields list of station indexes and total cost of path
  # for selected stations.
  def path(origin, destination, stations = nil, cost = 0, &block)
    # convert station names to indexes
    origin, destination = check_format(origin, destination)
    stations ||= [origin]
    current = stations.last

    if current == destination
      yield stations, cost
    else
      # call #path with each neighbour station that not in path list
      open_directions(current, stations).each do |st, c|
        path(origin, destination, stations + [st], cost + c, &block)
      end
    end
  end

  # => Array
  # convert array of station names to array of indexes
  # raise Argument error if map not include station
  def check_format(*args)
    args.collect do |s|
      s = case s
          when String  then map.keys.find { |k| map[k][:name] == s }
          when Integer then map.keys.find { |k| k == s }
          end
      s || fail(ArgumentError)
    end
  end

  # => Array
  # filters available direction from current station
  def open_directions(current, stations)
    map[current][:conns].reject { |st, _| stations.include?(st) }
  end

  # => Array
  # converts array of stations indexes to array of names
  def verbose_path(path)
    path.collect { |s| map[s][:name] }
  end
end
