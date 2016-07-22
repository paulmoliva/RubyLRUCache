class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return @head if empty?
    @head.next
  end

  def last
    return @tail if empty?
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    search(key) {|ptr| return ptr.val}
  end

  def include?(key)
    search(key) {|ptr| return true}
    false
  end

  def insert(key, val)
    if self.include?(key)
      update_key(key, val)
    else
      new_link = Link.new(key, val)
      @head.next = new_link if empty?
      new_link.prev = self.last
      self.last.next = new_link
      @tail.prev = new_link
      new_link.next = @tail
    end
  end

  def remove(key)
    prc = Proc.new do |ptr|
      next_link = ptr.next
      previous_link = ptr.prev
      next_link.prev = ptr.prev
      previous_link.next = ptr.next
    end
    search(key, &prc)
  end

  def each(&prc)
    ptr = @head.next
    until ptr == @tail
      prc.call(ptr)
      ptr = ptr.next
    end
    self
  end

  def update_key(key, val)
    search(key) {|ptr| ptr.val = val}
  end

  def search(key, &prc)
    ptr = @head
    until ptr == @tail 
      prc.call(ptr) if ptr.key == key
      ptr = ptr.next
    end
    nil
  end


  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
