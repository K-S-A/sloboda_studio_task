###############################################################################
# inmplemented #combinations
# recursively yields all combinations of correct braces expressions
# that contain defined number of braces pairs.
###############################################################################
module Braces
  def combinations(pairs, output = '', open = 0, close = 0, &block)
    # check arguments
    fail ArgumentError unless args_valid?(string: [output],
                                          integer: [open, close])

    # when output will match necessary format yields output
    if open == pairs && close == pairs
      yield output

    # else => recursively call `combinations` with updated params
    else
      combinations(pairs, output + '(', open + 1, close, &block) if open < pairs
      combinations(pairs, output + ')', open, close + 1, &block) if close < open
    end
  end

  private

  def args_valid?(args_hash)
    !args_hash.any? do |klass, args|
      args.any? { |a| !a.is_a?(Kernel.const_get(klass.to_s.capitalize)) }
    end
  end
end
