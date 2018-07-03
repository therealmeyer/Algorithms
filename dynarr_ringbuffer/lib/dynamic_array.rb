require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    if index >= length 
      raise "index out of bounds"
    else 
      return @store[index]
    end 
  end

  # O(1)
  def []=(index, value)
    if index >= length 
      raise "index out of bounds"
    else 
      @store[index] = value
    end 
  end

  # O(1)
  def pop
    raise "index out of bounds" if length <= 0
    popped = @store[length-1]
    @store[length-1] = nil 
    @length -= 1
    return popped
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if length + 1 > capacity 

    @store[length] = val
    @length += 1 
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if length <= 0

    shifted = @store[0]
    temp = StaticArray.new(capacity)
    (1...length).each do |i|
      temp[i-1] = self.store[i]
    end 

    @store = temp 
    @length -= 1

    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if length + 1 > capacity

    temp = StaticArray.new(capacity)
    temp[0] = val
    (0...length).each do |i|
      temp[i + 1] = @store[i]
    end

    @store = temp
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    resize = StaticArray.new(@capacity *2)
    (0...length).each do |i|
      resize[i] = @store[i]
    end 
    @store = resize 
    @capacity *= 2
  end
end
