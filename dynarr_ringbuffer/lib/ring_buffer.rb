require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    unless (index >= 0) && (index < length)
      raise "index out of bounds"
    else
      return self.store[(index + start_idx) % capacity]
    end
  end

  # O(1)
  def []=(index, val)
    unless (index >= 0) && (index < length)
      raise "index out of bounds"
    else
      self.store[(index + start_idx) % capacity] = val
    end
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0

    res = self[length - 1]
    self[length - 1] = nil
    self.length -= 1

    res
  end

  # O(1) ammortized
  def push(val)
    resize! if length == capacity

    self.length += 1
    self[length - 1] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" if length == 0

    res = self[0]
    self[0] = nil
    self.start_idx = (start_idx + 1) % capacity
    self.length -= 1

    res
  end

  # O(1) ammortized
  def unshift(val)
    resize! if length == capacity

    self.start_idx = (start_idx - 1) % capacity
    self.length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    double_cap = capacity * 2
    temp = StaticArray.new(double_cap)

    (0...length).each do |i|
      temp[i] = self[i]
    end 
    @store = temp 
    @capacity = double_cap
    @start_idx = 0
  end
end
