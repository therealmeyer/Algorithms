require_relative "heap"

class Array
  def heap_sort!
    (1...length).each do |i|
      BinaryMinHeap.heapify_up(self, i, i)
    end
    (length - 1).downto(1) do |i|
      self[i], self[0] = self[0], self[i]
      BinaryMinHeap.heapify_down(self, 0, i)
    end
    self.reverse!
  end
end

class Array
  def heap_sort!
    # Make it a max heap 
    prc = Proc.new do |el1, el2|
      -1 * (el1 <=> el2)
    end 

    pointer = 0 
    while pointer < self.length
      BinaryMinHeap.heapify_up(self, pointer, &prc)
      pointer += 1
    end 
    pointer -= 1

    while pointer >= 0
      self[0], self[pointer] = self[pointer], self[0]
      pointer -= 1 
      BinaryMinHeap.heapify_down(self, 0, pointer+1, &prc)
    end 
    self 
  end 
end