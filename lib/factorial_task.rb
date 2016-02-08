class Integer

  def factorial
    (2..self).reduce(1, :*) unless self < 0
  end

  def sum_digits
    self.to_s.chars.inject(0){ |sum, n| sum + n.to_i }
  end

end