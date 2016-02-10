###############################################################################
# inmplemented #correct_combinations
# recursively yields all combinations of correct braces expressions
# that contain defined number of braces pairs.
###############################################################################
module Braces
  def correct_combinations(pairs, output = '', open = 0, close = 0, &block)
    # check arguments
    unless output.is_a?(String) && open.is_a?(Integer) && close.is_a?(Integer)
      fail ArgumentError
    end

    # when output will match necessary format
    # yield output if block given
    if open == pairs && close == pairs
      yield output if block_given?

    # else => recursively call `correct_combinations` with updated params
    else
      if open < pairs
        correct_combinations(pairs, output + '(', open + 1, close, &block)
      end
      if close < open
        correct_combinations(pairs, output + ')', open, close + 1, &block)
      end
    end
  end
end
