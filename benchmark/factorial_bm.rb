require 'benchmark'
 
LOW_NUMBER = 1
LOW_REP = 2000000
HIGH_NUMBER = 99999**9999
HIGH_REP = 200

# Using #chars
def sum_digits_chars(num)
  num.to_s.chars.inject(0){ |sum, n| sum + n.to_i }
end
 
# Using #unpack and #inject with explicit block
def sum_digits_unpack(num)
  # numeric value for '0' character
  zero_ord = ?0.ord
  num.abs.to_s.unpack('c*').inject(0){ |sum, n| sum + n - zero_ord }
end
 
# Using #unpack and #inject without explicit block
# `.inject(:+)` runs faster due to "short-circuiting"
# => the fastest for both small and large numbers.
# For large numbers allmost 2x faster.
def sum_digits_unpack_1(num)
  # num_ord_arr => array of integers ('ords' of string's characters)
  num_ord_arr = num.abs.to_s.unpack('c*')

  # removing zero "base" from result # => i.to_s.ord = '0'.ord + i
  num_ord_arr.inject(:+) - num_ord_arr.length * ?0.ord
end

Benchmark.bm(32) do |b|
  b.report('sum_digits_chars(LOW_NUMBER):')       {LOW_REP.times {sum_digits_chars(LOW_NUMBER)}}
  b.report('sum_digits_unpack(LOW_NUMBER):')      {LOW_REP.times {sum_digits_unpack(LOW_NUMBER)}}
  b.report('sum_digits_unpack_1(LOW_NUMBER):')    {LOW_REP.times {sum_digits_unpack_1(LOW_NUMBER)}}

  b.report('sum_digits_chars(HIGH_NUMBER):')      {HIGH_REP.times {sum_digits_chars(HIGH_NUMBER)}}
  b.report('sum_digits_unpack(HIGH_NUMBER):')     {HIGH_REP.times {sum_digits_unpack(HIGH_NUMBER)}}
  b.report('sum_digits_unpack_1(HIGH_NUMBER):')   {HIGH_REP.times {sum_digits_unpack_1(HIGH_NUMBER)}}
end

# RESULTS
#                                        user     system      total        real
# sum_digits_chars(LOW_NUMBER):      2.940000   0.010000   2.950000 (  3.000835)
# sum_digits_unpack(LOW_NUMBER):     3.000000   0.020000   3.020000 (  3.048531)
# sum_digits_unpack_1(LOW_NUMBER):   2.900000   0.000000   2.900000 (  2.913710)

# sum_digits_chars(HIGH_NUMBER):     5.080000   0.000000   5.080000 (  5.177082)
# sum_digits_unpack(HIGH_NUMBER):    2.930000   0.060000   2.990000 (  3.077163)
# sum_digits_unpack_1(HIGH_NUMBER):  2.650000   0.000000   2.650000 (  2.727132)
