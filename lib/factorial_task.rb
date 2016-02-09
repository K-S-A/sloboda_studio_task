class Integer

  # => return integer or nil
  def factorial
    (2..self).reduce(1, :*) unless self < 0
  end

  # Using #unpack and #inject without explicit block
  # `.inject(:+)` runs faster due to "short-circuiting"
  # For large numbers allmost 2x faster than
  # `self.to_s.chars.inject(0){ |sum, n| sum + n.to_i }`
  # The fastest for both small and large numbers.
  # => return not-negative integer
  def sum_digits
    # num_ord_arr => array of integers ('ords' of string's characters)
    num_ord_arr = self.abs.to_s.unpack('c*')

    # removing zero "base" from result # => i.to_s.ord = '0'.ord + i
    num_ord_arr.inject(:+) - num_ord_arr.length * ?0.ord
  end

end