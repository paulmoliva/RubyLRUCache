class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.reduce(0.hash){|sum, el| sum += sum.hash ^ el.hash}
  end
end

class String
  def hash
    chrs = self.chars.map(&:ord)
    chrs.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    k = self.keys.map(&:to_s)
    k = k.sort.reduce(0){|sum, el| sum += sum + el.to_s.ord}.hash
    v = self.values.sort.reduce(0){|sum, el| sum += sum + el.to_s.ord}.hash
    k + v
  end
end
