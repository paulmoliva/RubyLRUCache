require 'byebug'
class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    begin
      @store[i]
    rescue
      nil
    end
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    i = 0
    while i < @store.length
      return true if @store[i] == val
      i += 1
    end
    false
  end

  def push(val)
    if count == capacity
      resize!
      @store[count] = val
    else
      @store[count] = val
    end
    @count += 1
  end

  def unshift(val)
    if count == capacity
      resize!
    end
    i = last_index
    while i >= 0
      @store[i+1] = @store[i]
      i -= 1
    end
    @store[0] = val
    @count += 1
  end

  def pop
    begin
      return_val = @store[last_index]
      @store[last_index] = nil
      @count -= 1
      return_val
    rescue
      nil
    end
  end

  def shift
    #begin
      return nil if first.nil?
      return_val = first
      i = 0
      initial_last_index = last_index
      while i <= initial_last_index
        @store[i] = @store[i + 1]
        i += 1
      end
      @count -= 1
      return_val
    #rescue
      #nil
    #end
  end

  def first
    begin
      @store[0]
    rescue
      nil
    end
  end

  def last
    @store[last_index]

  end

  def each(&prc)
    i = 0
    while i <= last_index
      prc.call(@store[i])
      i += 1
    end
    @store
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless count == other.count
    i = 0
    until i == capacity
      return false unless self[i] == other[i]
      i += 1
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_static_arr = StaticArray.new(capacity * 2)
    i = 0
    while i < @store.length
      new_static_arr[i] = @store[i]
      i += 1
    end
    @store = new_static_arr
  end

  def last_index
    i = capacity - 1
    while @store[i] == nil
      i -= 1
    end
    i
  end
end
