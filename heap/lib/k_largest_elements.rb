require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new
  k.times do
      heap.push(array.pop)
  end
  until array.empty?
      heap.push(array.pop)
      heap.extract
  end
  heap.store
end
